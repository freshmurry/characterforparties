class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @barbershops = current_user.barbershops
  end
end