class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    barbershop = Barbershop.find(params[:barbershop_id])

    if current_user == barbershop.user
      flash[:alert] = "You cannot book your own service!"
    elsif current_user.stripe_id.blank?
       flash[:alert] = "Please update your payment method!"
       returen redirect_to payment_method_path
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i + 1

      special_dates = barbershop.calendars.where(
        "status = ? AND day BETWEEN ? AND ? AND price <> ?",
        0, start_date, end_date, barbershop.price
      )
      
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.barbershop = barbershop
      @reservation.price = barbershop.price
      # @reservation.total = barbershop.price * days
      # @reservation.save
      
      @reservation.total = barbershop.price * (days - special_dates.count)
      special_dates.each do |date|
          @reservation.total += date.price
      end
      
      if @reservation.Waiting!
        if barbershop.Request?
          flash[:notice] = "Request sent successfully"
        else
          charge(barbershop, @reservation)
        end
      else
        flash[:alert] = "Cannot book an appointment"
      end
      
    end
    redirect_to barbershop
  end

  def your_appointments
    @appointments = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @barbershops = current_user.barbershops
  end
  
  def approve
    charge(@reservation.barbershop, @reservation)
    redirect_to your_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to your_reservations_path
  end

  private
  
  def send_sms(barbershop, reservation)
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+3125488878',
      to: barbershop.user.phone_number,
      body: "#{reservation.user.fullname} booked a '#{barbershop.style_type}'"
    )
  end  
  
    def charge(barbershop, reservation)
      if !reservation.user.stripe_id.blank?
        customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
        charge = Stripe::Charge.create(
          :customer => customer.id,
          :amount => reservation.total * 100,
          :description => barbershop.listing_name,
          :currency => "usd", 
          :destination => {
            :amount => reservation.total * 88, # 88% of the total amount goes to the Barber
            :account => barbershop.user.merchant_id # Barber's Stripe customer ID
          }
        )
  
        if charge
          reservation.Approve!
          ReservationMailer.send_email_to_client(reservation.user, barbershop).deliver_later if reservation.user.setting.enable_email
          send_sms(barbershop, reservation) if barbershop.user.setting.enable_sms
          flash[:notice] = "Reservation created successfully!"
        else
          reservation.Declined!
          flash[:notice] = "Cannot charege with this payment method!"
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
      params.require(:reservation).permit(:start_date, :end_date)
    end
end
