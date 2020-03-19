class ServiceController < ApplicationController
  # before_action :set_service, only: [:show, :edit, :update, :destroy]
  
  def index
    @services = current_user.services
  end
  
  def show
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def edit
  end
  
  def create
    @service = Service.new(service_params)
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully deleted' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :price, :instant)
    end
end
