class PhotosController < ApplicationController

 def create
    @venue = Venue.find(params[:venue_id])

    if params[:image]
      params[:image].each do |img|
        @venue.photos.create(image: img)
      end

      @photos = @venue.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  # def create
  #   @venue = Venue.find(params[:venue_id])
  #   # @photos = @venue.photos

  #   if params[:venue][:images]
  #     params[:venue][:images].each do |img|
  #       @venue.photos.create(image: img)
  #     end

  #     redirect_back(fallback_location :request.referer, notice: "Saved...")
  #   end
  # end

  def destroy
    @photo = Photo.find(params[:id])
    @venue = @photo.venue

    @photo.destroy
    @photos = Photo.where(venue_id: @venue.id)

    respond_to :js
  end
end