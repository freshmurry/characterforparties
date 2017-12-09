class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @venues = current_user.venues
  end
end