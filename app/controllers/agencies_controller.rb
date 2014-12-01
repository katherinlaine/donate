class AgenciesController < ApplicationController
  def new
    @agency = Agency.new
    @food_types = FoodType.all
  end

  def create
    agency = Agency.new(agency_params)
    agency.food_type_ids = agency_params[:food_type_ids]

    if agency.save
      redirect_to agency_path(agency)
    else
      render :new
    end
  end

  def show
    @agency = Agency.find(params[:id])
  end

  def edit
    @agency = Agency.find(params[:id])
    @food_types = FoodType.all
  end

  def update
    agency = Agency.find(params[:id])
    agency.food_type_ids = agency_params[:food_type_ids]

    if agency.update(agency_params)
      redirect_to agency_path(agency)
    else
      render :else
    end
  end

  def index
    @agencies = Agency.all
  end

  private

  def agency_params
    params.require(:agency).permit(
      :name,
      :contact,
      :phone,
      :address,
      :city,
      :zipcode,
      :notes,
      :food_type_ids => []
    )
  end
end
