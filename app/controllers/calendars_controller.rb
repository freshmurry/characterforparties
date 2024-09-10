class CalendarsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def create
    date_from = Date.parse(calendar_params[:start_date])
    date_to = Date.parse(calendar_params[:end_date])

    (date_from..date_to).each do |date|
      calendar = Calendar.where(character_id: params[:character_id], day: date)

      if calendar.present?
        calendar.update_all(price: calendar_params[:price], status: calendar_params[:status])
      else
        Calendar.create(
          character_id: params[:character_id],
          day: date,
          price: calendar_params[:price],
          status: calendar_params[:status]
        )
      end
    end

    redirect_to host_calendar_path
  end
  
  def host
    @characters = current_user.characters
  
    # Initialize @character to avoid the nil error
    @character = @characters.first if @characters.present?
  
    params[:start_date] ||= Date.current.to_s
    params[:character_id] ||= @character ? @character.id : nil
  
    if params[:q].present?
      params[:start_date] = params[:q][:start_date]
      params[:character_id] = params[:q][:character_id]
    end
  
    @search = Reservation.ransack(params[:q])
  
    if params[:character_id]
      @character = Character.find(params[:character_id])
      start_date = Date.parse(params[:start_date])
  
      first_of_month = (start_date - 1.month).beginning_of_month
      end_of_month = (start_date + 1.month).end_of_month
  
      @events = @character.reservations.joins(:user)
                      .select('reservations.*, users.fullname, users.image, users.email, users.uid')
                      .where('(start_date BETWEEN ? AND ?) AND status <> ?', first_of_month, end_of_month, 2)
      @events.each { |e| e.image = image_url(e) }
      @days = Calendar.where("character_id = ? AND day BETWEEN ? AND ?", params[:character_id], first_of_month, end_of_month)
    else
      @character = nil
      @events = []
      @days = []
    end
  end

  private
    def calendar_params
      params.require(:calendar).permit([:price, :status, :start_date, :end_date])
    end
end