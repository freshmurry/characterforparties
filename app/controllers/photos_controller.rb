class PhotosController < ApplicationController
  before_action :set_character, only: [:create, :destroy]

  def create
    if params[:character][:photos].present?
      params[:character][:photos].each do |photo_file|
        @character.photos.create(photo_params.merge(image: photo_file)) # Use strong parameters
      end
      redirect_to @character, notice: 'Photos were successfully uploaded.'
    else
      redirect_to @character, alert: 'No photos uploaded.'
    end
  end

  def destroy
    @photo = @character.photos.find(params[:id])
    @photo.destroy
    
    respond_to do |format|
      format.html { redirect_to edit_character_path(@character), notice: 'Photo was successfully deleted.' }
      format.js   # This will render destroy.js.erb
    end
  end

  private

  def set_character
    @character = Character.find(params[:character_id])
  end
end
