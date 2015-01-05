class Admin::FoodTypesController < AdminController
  def create
    @food_type = FoodType.create(food_type_params)

    redirect_to admin_food_types_path
  end

  def edit
    @food_type = FoodType.find(params[:id])
  end

  def update
    @food_type = FoodType.find(params[:id])
    @food_type.update(food_type_params)

    redirect_to admin_food_types_path
  end

  def destroy
    @food_type = FoodType.find(params[:id])
    @food_type.destroy

    redirect_to admin_food_types_path
  end

  def index
    @food_type = FoodType.new
    @food_types = FoodType.all
  end

  private

  def food_type_params
    params.require(:food_type).permit(:name, :feeding_america_id)
  end
end
