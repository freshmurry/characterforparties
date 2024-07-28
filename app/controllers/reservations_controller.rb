class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:notify]
  before_action :set_reservation, only: [:approve, :decline]
  before_action :set_bouncehouse, only: [:create, :preview]

  def preview
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    @conflict = Reservation.is_conflict(@bouncehouse, start_date, end_date)
    respond_to do |format|
      format.json { render json: { conflict: @conflict } }
    end
  end

  def create
    if current_user == @bouncehouse.user
      flash[:alert] = "You cannot book your own Bouncehouse!"
      redirect_to @bouncehouse and return
    elsif current_user.stripe_id.blank?
      flash[:alert] = "Please update your payment method!"
      redirect_to payment_method_path and return
    end

    start_date = Date.parse(reservation_params[:start_date])
    end_date = Date.parse(reservation_params[:end_date])
    days = (end_date - start_date).to_i + 1

    special_dates = @bouncehouse.calendars.where(
      "status = ? AND day BETWEEN ? AND ? AND price <> ?",
      0, start_date, end_date, @bouncehouse.price
    )

    @reservation = current_user.reservations.build(reservation_params)
    @reservation.bouncehouse = @bouncehouse
    @reservation.price = @bouncehouse.price
    @reservation.total = calculate_total(days, special_dates)

    if @reservation.Waiting!
      if @bouncehouse.Request?
        flash[:notice] = "Request sent successfully"
      else
        charge(@bouncehouse, @reservation)
      end
    else
      flash[:alert] = "Cannot make a reservation"
    end

    redirect_to @bouncehouse
  end

  def previous_reservations
    @spaces = current_user.reservations.order(start_date: :asc)
  end

  def current_reservations
    @bouncehouses = current_user.bouncehouses
  end

  def approve
    charge(@reservation.bouncehouse, @reservation)
    redirect_to current_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to current_reservations_path
  end

  private

  def set_bouncehouse
    @bouncehouse = Bouncehouse.find(params[:bouncehouse_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def charge(bouncehouse, reservation)
    return if reservation.user.stripe_id.blank?

    begin
      customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: reservation.total * 100,
        description: bouncehouse.listing_name,
        currency: "usd",
        destination: {
          amount: reservation.total * 95, # 95% of the total amount goes to the Host, 5% is company fee
          account: bouncehouse.user.merchant_id # bouncehouse's Stripe customer ID
        }
      )

      if charge
        reservation.Approved!
        ReservationMailer.send_email_to_guest(reservation.user, bouncehouse).deliver_later if reservation.user.setting.enable_email
        send_sms(bouncehouse, reservation) if bouncehouse.user.setting.enable_sms
        flash[:notice] = "Reservation created successfully!"
      else
        reservation.Declined!
        flash[:alert] = "Cannot charge with this payment method!"
      end
    rescue Stripe::CardError => e
      reservation.Declined!
      flash[:alert] = e.message
    end
  end

  def calculate_total(days, special_dates)
    base_total = @bouncehouse.price * (days - special_dates.count)
    special_dates.each do |date|
      base_total += date.price
    end
    base_total
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :bouncehouse_id)
  end
end
