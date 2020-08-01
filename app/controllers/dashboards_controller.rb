class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pools = current_user.pools
  end
end