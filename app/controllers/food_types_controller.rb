class FoodTypesController < ApplicationController
  def create
    @food_type = FoodType.new(food_type_params)
    @food_type.name.capitalize!

    if @food_type.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def index
    @food_types = FoodType.all
    @food_type = FoodType.new
  end

  private

  def food_type_params
    params.require(:food_type).permit(:name)
  end
end
