class PagesController < ApplicationController
  def home
    @characters = Character.where(active: true).limit(3)
  end

  def search
    # STEP 1: Handle the location search parameter
    if params[:search].present?
      session[:loc_search] = params[:search].strip
    end

    # Debugging: Check the value of session[:loc_search]
    Rails.logger.debug "Location search: #{session[:loc_search].inspect}"

    # STEP 2: Perform the search based on the location stored in the session
    if session[:loc_search].present?
      begin
        @characters = Character.where(active: true).near(session[:loc_search], 5)
      rescue ArgumentError => e
        Rails.logger.error "Geocoder error: #{e.message}"
        @characters = Character.where(active: true)
      end
    else
      @characters = Character.where(active: true)
    end

    # STEP 3: Use Ransack for more advanced search functionality if needed
    @search = @characters.ransack(params[:q])
    @characters = @search.result

    @arrCharacters = @characters.to_a

    if (params[:start_date] && params[:end_date] && !params[:start_date].empty? &&  !params[:end_date].empty?)
      
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @characters.each do |character|

        not_available = character.reservations.where(
          "((? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date))
          AND status = ?",
          start_date, end_date,
          start_date, end_date,
          start_date, end_date,
          1
        ).limit(1)
        
        not_available_in_calendar = Calendar.where(
          "character_id = ? AND status = ? AND day <= ? AND day >= ?",
          character.id, 1, end_date, start_date
        ).limit(1)
        
        if not_available.length > 0 || not_available_in_calendar.length > 0
          @arrCharacters.delete(character)
        end
      end
    end
  end
end
