class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    venue = Venue.find(params[:venue_id])

    if current_user == venue.user
      flash[:alert] = "You cannot book your own venue!"
    elsif current_user.stripe_id.blank?
       flash[:alert] = "Please update your payment method!"
       return redirect_to payment_path
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i + 1

      special_dates = venue.calendars.where(
        "status = ? AND day BETWEEN ? AND ? AND price <> ?",
        0, start_date, end_date, venue.price
      )
      
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.venue = venue
      @reservation.price = venue.price
      # @reservation.total = venue.price * days
      # @reservation.save
      
      @reservation.total = venue.price * (days - special_dates.count)
      special_dates.each do |date|
          @reservation.total += date.price
      end
      
      if @reservation.Waiting!
        if venue.Request?
          flash[:notice] = "Request sent successfully"
        else
          charge(venue, @reservation)
        end
      else
        flash[:alert] = "Cannot make a reservation"
      end
      
    end
    redirect_to venue
  end

  def previous_reservations
    @spaces = current_user.reservations.order(start_date: :asc)
  end

  def current_reservations
    @venues = current_user.venues
  end
  
  def approve
    charge(@reservation.venue, @reservation)
    redirect_to current_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to current_reservations_path
  end

  private
  
  def send_sms(venue, reservation)
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+3125488878',
      to: venue.user.phone_number,
      body: "#{reservation.user.fullname} booked your '#{venue.listing_name}'"
    )
  end
  
    def charge(venue, reservation)
      if !reservation.user.stripe_id.blank?
        customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
        charge = Stripe::Charge.create(
          :customer => customer.id,
          :amount => reservation.total * 100,
          :description => venue.listing_name,
          :currency => "usd", 
          :destination => {
            :amount => reservation.total * 80, # 80% of the total amount goes to the Host Venue, 20% is revenue for ShindigSpace
            :account => venue.user.merchant_id # Venue's Stripe customer ID
          }
        )
  
        if charge
          reservation.Approved!
          ReservationMailer.send_email_to_guest(reservation.user, venue).deliver_later if reservation.user.setting.enable_email
          send_sms(venue, reservation) if venue.user.setting.enable_sms
          flash[:notice] = "Reservation created successfully!"
        else
          reservation.Declined!
          flash[:notice] = "Cannot charge with this payment method!"
        end
      end
    rescue Stripe::CardError => e  
      reservation.declined!
      flash[:notice] = e.message
    end
    
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :service)
    end
end