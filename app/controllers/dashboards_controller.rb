class DashboardsController < ApplicationController
  def show
    @food_types = FoodType.all
  end
end
