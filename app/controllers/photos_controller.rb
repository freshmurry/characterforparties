class PhotosController < ApplicationController

  def create
    @pool = Pool.find(params[:pool_id])

    if params[:images]
      params[:images].each do |img|
        @pool.photos.create(image: img)
      end

      @photos = @pool.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @pool = @photo.pool

    @photo.destroy
    @photos = Photo.where(pool_id: @pool.id)

    respond_to :js
  end
end
