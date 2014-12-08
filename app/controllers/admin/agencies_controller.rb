class Admin::AgenciesController < AdminController
  def new
    @agency = Agency.new
  end

  def create
    @agency = Agency.new(agency_params)
    if @agency.save
      redirect_to agency_path(@agency)
    else
      render :new
    end
  end

  def edit
    @agency = Agency.find(params[:id])
  end

  def update
    @agency = Agency.find(params[:id])

    if @agency.update(agency_params)
      redirect_to agency_path(@agency)
    else
      render :edit
    end
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
end
