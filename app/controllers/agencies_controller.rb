class AgenciesController < ApplicationController
  def new
    @agency = Agency.new
  end

  def create
    @agency = Agency.new(agency_params)

    if @agency.save
      redirect_to dashboard_path
    end
  end

  private 

  def agency_params
    params.require(:agency).permit(:name, :contact, :phone, :address, :city, :zipcode, :notes)
  end
end
