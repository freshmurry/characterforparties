class VenuesController < ApplicationController
  before_action :set_venue, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show, :preload, :preview]
  before_action :is_authorized, only: [:listing, :service, :pricing, :description, :photo_upload, :amenities, :location, :update]
  
  def index
    @venues = current_user.venues
  end

  def new
    @venue = current_user.venues.build
  end

  def create
    # This code makes host register with Stripe first. We want people to create their listing without having to signup with Stripe first.
    # if !current_user.is_active_host
    #   return redirect_to payout_path, alert: "Please Connect to Stripe Express first."
    # end
    
    @venue = current_user.venues.build(venue_params)
    if @venue.save
      redirect_to venue_path(@venue), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
    
    # respond_to do |format|
    #   @project.services.any? && current_user.can_receive_payments?
    #   CreateServicePlansJob.perform_now(@project)
    # end
  end
  
  def edit
    if current_user.id == @venue.user.id
      @photos = @venue.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end
  
  def show
    @photos = @venue.photos
    @guest_reviews = @venue.guest_reviews
  end
  
  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @venue.photos
  end

  def amenities
  end

  # def location
  # end

  def update
    new_params = venue_params
    new_params = venue_params.merge(active: true) if is_ready_venue

    if @venue.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
  end
  
  #---- RESERVATIONS ----
  def preload
    today = Date.today
    reservations = @venue.reservations.where("(start_date >= ? OR end_date >= ?) AND status = ?", today, today, 1)
    unavailable_dates = @venue.calendars.where("status = ? AND day > ?", 1, today)

    special_dates = @venue.calendars.where("status = ? AND day > ? AND price <> ?", 0, today, @venue.price)
    
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
      conflict: is_conflict(start_date, end_date, @venue)
    }

    render json: output
  end
  
  private
    def is_conflict(start_date, end_date, venue)
      check = venue.reservations.where("(? < start_date AND end_date < ?) AND status = ?", start_date, end_date, 1)
      check_2 = venue.calendars.where("day BETWEEN ? AND ? AND status = ?", start_date, end_date, 1).limit(1)
      
      check.size > 0 || check_2.size > 0 ? true : false 
    end

    def set_venue
      @venue = Venue.find(params[:id])
    end

    def is_authorized
      redirect_to root_path, alert: "You don't have permission" unless current_user.id == @venue.user_id
    end

    def is_ready_venue
      !@venue.active && !@venue.price.blank? && !@venue.listing_name.blank? && !@venue.photos.blank? && !@venue.address.blank?
    end

    def venue_params
      params.require(:venue).permit(:venue_type, :event_type, :rest_room, :accommodate, :listing_name, :service, :description, :address, :is_kitchen, 
      :is_tables, :is_chairs, :is_microphone, :is_projector, :is_speakers, :is_self_parking, :is_valet_parking, :is_garage_parking, 
      :is_air, :is_heating, :is_wifi, :is_custodial, :is_accessible, :is_tablecloths, :is_wheelchair, :is_stage, :price, :active, :instant, services_attributes: [:id, :_destroy, :title, :description, :price])
    end
end