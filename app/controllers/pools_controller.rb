class PoolsController < ApplicationController
  before_action :set_pool, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show, :preload, :preview]
  before_action :is_authorized, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
  
  def index
    @pools = current_user.pools
  end

  def new
    @pool = current_user.pools.build
  end

  def create
    # This code makes host register with Stripe first. We want people to create their listing without having to signup with Stripe first.
    # if !current_user.is_active_host
    #   return redirect_to payout_path, alert: "Please Connect to Stripe Express first."
    # end
    
    @pool = current_user.pools.build(pool_params)
    if @pool.save
      redirect_to listing_pool_path(@pool), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
  end

  def show
    @photos = @pool.photos
    @guest_reviews = Review.where(type: "GuestReview")
  end
  
  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @pool.photos
  end

  def amenities
  end

  def location
  end

  def update
    new_params = pool_params
    new_params = pool_params.merge(active: true) if is_ready_pool

    if @pool.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
    # redirect_to pool_path(@pool), notice: "Saved..."
  end
  
  #---- RESERVATIONS ----
  def preload
    today = Date.today
    reservations = @pool.reservations.where("(start_date >= ? OR end_date >= ?) AND status = ?", today, today, 1)
    unavailable_dates = @pool.calendars.where("status = ? AND day > ?", 1, today)

    special_dates = @pool.calendars.where("status = ? AND day > ? AND price <> ?", 0, today, @pool.price)
    
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
      conflict: is_conflict(start_date, end_date, @pool)
    }

    render json: output
  end
  
  private
    def is_conflict(start_date, end_date, pool)
      check = pool.reservations.where("(? < start_date AND end_date < ?) AND status = ?", start_date, end_date, 1)
      check_2 = pool.calendars.where("day BETWEEN ? AND ? AND status = ?", start_date, end_date, 1).limit(1)
      
      check.size > 0 || check_2.size > 0 ? true : false 
    end

    def set_pool
      @pool = Pool.find(params[:id])
    end

    def is_authorized
      redirect_to root_path, alert: "You don't have permission" unless current_user.id == @pool.user_id
    end

    def is_ready_pool
      !@pool.active && !@pool.price.blank? && !@pool.listing_name.blank? && !@pool.photos.blank? && !@pool.address.blank?
    end

    def pool_params
      params.require(:pool).permit(:pool_type, :restrooms, :accommodate, :listing_name, :description, :address, :is_chairs, 
      :is_speaker, :is_parking, :is_garage_parking, :is_heated_pool, :is_accessible, :price, :active, :instant)
    end
end