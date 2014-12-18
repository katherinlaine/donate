class AgencyAdmin::AgenciesController < ApplicationController
  def edit
    find_agency
  end

  def update
    find_agency

    if @agency.update(agency_params)
      flash[:notice] = "Your updates were saved."
      redirect_to agency_admin_agency_path(@agency)
    else
      flash[:notice] = "We were unable to save your changes."
      render :edit
    end
  end

  def show
    find_agency
  end

  private

  def agency_params
    params.require(:agency).permit(
      :address,
      :city,
      :contact,
      :name,
      :notes,
      :phone,
      :zipcode,
      food_type_ids: []
    )
  end

  def require_agency_admin_access
    unless has_rights_to_edit(agency)
      redirect_to root_path
    end
  end

  def find_agency
    @agency = Agency.find(params[:id])
  end
end
