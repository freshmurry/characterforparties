class CharactersController < ApplicationController
  before_action :set_character, only: %i[:update, :edit]
  # before_action :set_character, only: [:index, :new, :create, :update, :edit]

  def index
    @characters = current_user.characters

    set_meta_tags(
      title: 'My Character Listing',
      description: 'Check out our amazing character listing.',
      keywords: 'Character for Parties',
      image: 'default_image_url',  # Default image if specific listing image is not set
      og: {
        title: @character&.listing_name || 'Default Title',
        description: @character&.description || 'Default Description',
        type: 'website',
        url: character_url(@character),
        image: @character&.photos || 'default_image_url',
        site_name: 'Test'
      },
      twitter: {
        card: 'summary',
        site: '@sitehandle',
        title: @character&.listing_name || 'Default Title',
        description: @character&.description || 'Default Description',
        image: @character&.photos || 'default_image_url'
      }
    )
  end

  def show
    @character = Character.find(params[:id])
    @photos = @character.photos
    @guest_reviews = Review.where(type: "GuestReview", character_id: @character.id)
    @reservation = Reservation.new
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Character not found."
    redirect_to root_path
  end

  def new
    @character = current_user.characters.build
  end

  def create
    @character = current_user.characters.build(character_params)

    if @character.save
      if params[:images]
        params[:images].each do |image|
          @character.photos.create(image: image)
        end
      end

      @photos = @character.photos
      redirect_to character_path(@character), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    redirect_to root_path, notice: "You don't have permission." unless current_user.id == @character.user.id
    @photos = @character.photos
  end

  def update
    if @character.update(character_params)
      if params[:character][:photos]
        params[:character][:photos].each do |photo|
          @character.photos.create(image: photo)
        end
      end
      redirect_to @character, notice: 'Listing successfully updated.'
    else
      render :edit
    end
  end
  
  # ----- RESERVATIONS -----
  def preload_reservations
    @character = Character.find(params[:id])
    @reservations = @character.reservations.where("start_date <= ? AND end_date >= ?", Date.today, Date.today)
    
    respond_to do |format|
      format.json { render json: @reservations }
    end
  end

  def preview_reservations
    @character = Character.find(params[:id])
    start_date = params[:start_date]
    end_date = params[:end_date]
    @conflict = Reservation.is_conflict(@character, start_date, end_date)

    respond_to do |format|
      format.json { render json: { conflict: @conflict } }
    end
  end
  
  def destroy
    @character.destroy
    redirect_to root_path, notice: "Deleted..."
  end
  
  private

  def set_character
    @character = Character.find(params[:id])
  end

  # def authorized_user!
  #   redirect_to root_path, alert: "You don't have permission" unless current_user.id == @character.user_id
  # end

  def character_params
    params.require(:character).permit(:character_type, :time_limit, :instant, :listing_name, :description, :address, :price, :active, photos_attributes: [:id, :image, :_destroy])
  end
end
