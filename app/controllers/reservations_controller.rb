class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    pool = Pool.find(params[:pool_id])

    if current_user == pool.user
      flash[:alert] = "You cannot book your own service!"
    elsif current_user.stripe_id.blank?
       flash[:alert] = "Please update your payment method!"
       returen redirect_to payment_method_path
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i + 1

      special_dates = pool.calendars.where(
        "status = ? AND day BETWEEN ? AND ? AND price <> ?",
        0, start_date, end_date, pool.price
      )
      
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.pool = pool
      @reservation.price = pool.price
      # @reservation.total = pool.price * days
      # @reservation.save
      
      @reservation.total = pool.price * (days - special_dates.count)
      special_dates.each do |date|
          @reservation.total += date.price
      end
      
      if @reservation.Waiting!
        if pool.Request?
          flash[:notice] = "Request sent successfully"
        else
          charge(pool, @reservation)
        end
      else
        flash[:alert] = "Cannot book an appointment"
      end
      
    end
    redirect_to pool
  end

  def your_appointments
    @appointments = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @pools = current_user.pools
  end
  
  def approve
    charge(@reservation.pool, @reservation)
    redirect_to your_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to your_reservations_path
  end

  private
  
  def send_sms(pool, reservation)
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+3125488878',
      to: pool.user.phone_number,
      body: "#{reservation.user.fullname} booked a '#{pool.style_type}'"
    )
  end  
  
    def charge(pool, reservation)
      if !reservation.user.stripe_id.blank?
        customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
        charge = Stripe::Charge.create(
          :customer => customer.id,
          :amount => reservation.total * 100,
          :description => pool.listing_name,
          :currency => "usd", 
          :destination => {
            :amount => reservation.total * 88, # 88% of the total amount goes to the Barber
            :account => pool.user.merchant_id # Barber's Stripe customer ID
          }
        )
  
        if charge
          reservation.Approve!
          ReservationMailer.send_email_to_client(reservation.user, pool).deliver_later if reservation.user.setting.enable_email
          send_sms(pool, reservation) if pool.user.setting.enable_sms
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
