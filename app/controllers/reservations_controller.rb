class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:notify]
  before_action :set_reservation, only: [:approve, :decline]
  before_action :set_character, only: [:create, :preview]

  def preview
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    @conflict = Reservation.is_conflict(@character, start_date, end_date)
    respond_to do |format|
      format.json { render json: { conflict: @conflict } }
    end
  end

  def create
    if current_user == @character.user
      flash[:alert] = "You cannot book your own Character"
      redirect_to @character and return
    elsif current_user.stripe_id.blank?
      flash[:alert] = "Please update your payment method!"
      redirect_to payment_method_path and return
    end

    start_date = Date.parse(reservation_params[:start_date])
    end_date = Date.parse(reservation_params[:end_date])
    days = (end_date - start_date).to_i + 1

    special_dates = @character.calendars.where(
      "status = ? AND day BETWEEN ? AND ? AND price <> ?",
      0, start_date, end_date, @character.price
    )

    @reservation = current_user.reservations.build(reservation_params)
    @reservation.character = @character
    @reservation.price = @character.price
    @reservation.total = calculate_total(days, special_dates)

    if @reservation.Waiting!
      if @character.Request?
        flash[:notice] = "Request sent successfully"
      else
        charge(@character, @reservation)
      end
    else
      flash[:alert] = "Cannot make a reservation"
    end

    redirect_to @character
  end

  def previous_reservations
    @spaces = current_user.reservations.order(start_date: :asc)
  end

  def current_reservations
    @characters = current_user.characters
  end

  def approve
    charge(@reservation.character, @reservation)
    redirect_to current_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to current_reservations_path
  end

  private

  def set_character
    @character = Character.find(params[:character_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def charge(character, reservation)
    return if reservation.user.stripe_id.blank?

    begin
      customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: reservation.total * 100,
        description: character.listing_name,
        currency: "usd",
        destination: {
          amount: reservation.total * 95, # 95% of the total amount goes to the Host, 5% is company fee
          account: character.user.merchant_id # bcharacter's Stripe customer ID
        }
      )

      if charge
        reservation.Approved!
        ReservationMailer.send_email_to_guest(reservation.user, character).deliver_later if reservation.user.setting.enable_email
        send_sms(character, reservation) if character.user.setting.enable_sms
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
    base_total = @characters.price * (days - special_dates.count)
    special_dates.each do |date|
      base_total += date.price
    end
    base_total
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :character_id)
  end
end
