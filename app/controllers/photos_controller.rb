class PhotosController < ApplicationController

  # def create
  #   @venue = Venue.find(params[:venue_id])

  #   if params[:images]
  #     params[:images].each do |img|
  #     @venue.photos.create(image: img)
  #   end

  #     @photos = @venue.photos
  #     redirect_back(fallback_location: request.referer, notice: "Saved...")
  #   end
  # end
  
  def create
    @venue = Venue.find(params[:venue_id])
    @photos = @venue.photos
    
    if params[:images]
      params[:images].each do |img|
        @venue.photos.create(image: img)
      end
      redirect_back(fallback_location:request.referer, notice: "Saved...")
    end
  end
  
  # Ruby 2.3+ you can use safe navigation with &
  # def create
  #   @venue = Venue.find(params[:venue_id])
  #   params[:images]&.each{|img| @venue.photos.create(image: img)}
  #   redirect_back(fallback_location: request.referer, notice: "Saved...")
  # end

  def destroy
    @photo = Photo.find(params[:id])
    @venue = @photo.venue

    @photo.destroy
    @photos = Photo.where(venue_id: @venue.id)

    respond_to :js
  end
end