class PhotosController < ApplicationController

  def create
    @barbershop = Barbershop.find(params[:barbershop_id])

    if params[:images]
        params[:images].each do |img|
        @barbershop.photos.create(image: img)
      end

      @photos = @barbershop.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @barbershop = @photo.barbershop

    @photo.destroy
    @photos = Photo.where(barbershop_id: @barbershop.id)

    respond_to :js
  end
end
