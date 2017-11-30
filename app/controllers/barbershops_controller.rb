class BarbershopsController < ApplicationController
  before_action :set_barbershop, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorized, only: [:listing, :pricing, :description, :photo_upload, :extras, :location, :address, :update]

  def index
    @barbershops = current_user.barbershops
  end

  def new
    @barbershop = current_user.barbershops.build
  end

  def create
    if current_user.is_active_barber
      return redirect_to payout_method_path, alert: "Please Connect to Stripe Express first."
    end
      
    @barbershop = current_user.barbershops.build(barbershop_params)
    if @barbershop.save
      redirect_to listing_barbershop_path(@barbershop), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
  end
  
  def show
    @photos = @barbershop.photos
    @client_reviews = Review.where(type: "ClientReview")
    # @client_reviews = @barbershop.client_reviews
  end
  
  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @barbershop.photos
  end

  def extras
  end

  def location
  end

  def update
    new_params = barbershop_params
    new_params = barbershop_params.merge(active: true) if is_ready_barbershop

    if @barbershop.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
  end
  
  #---- RESERVATIONS ----
  def preload
    today = Date.today
    reservations = @barbershop.reservations.where("(start_date >= ? OR end_date >= ?) AND status = ?", today, today, 1)
    unavailable_dates = @barbershop.calendars.where("status = ? AND day > ?", 1, today)

    special_dates = @barbershop.calendars.where("status = ? AND day > ? AND price <> ?",0, today, @barbershop.price)
    
    render json: {
        reservations: reservations,
        unavailable_dates: unavailable_dates,
        special_dates: special_dates
    }
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @barbershop)
    }

    render json: output
  end
  
  private
    def is_conflict(start_date, end_date, barbershop)
      check = barbershop.reservations.where("(? < start_date AND end_date < ?) AND status = ?", start_date, end_date, 1)
      check_2 = barbershop.calendars.where("day BETWEEN ? AND ? AND status = ?", start_date, end_date, 1).limit(1)
      
      check.size > 0 || check_2.size > 0 ? true : false 
    end

    def set_barbershop
      @barbershop = Barbershop.find(params[:id])
    end

    def is_authorized
      redirect_to root_path, alert: "You don't have permission" unless current_user.id == @barbershop.user_id
    end

    def is_ready_barbershop
      !@barbershop.active && !@barbershop.price.blank? && !@barbershop.listing_name.blank? && !@barbershop.photos.blank? && !@barbershop.address.blank?
    end

    def barbershop_params
      params.require(:barbershop).permit(:location_type, :address, :stylist_type, :style_type, :listing_name, :summary, :is_accept_card, :is_accept_card, :payment_type, :additional_service, :service, :extras, :price, :tip, :active, :instant)
    end
end