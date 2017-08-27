class HomeController < ApplicationController
  def index
  end
  def show
    @favorite_hotels = current_user.hotels
  end
end
