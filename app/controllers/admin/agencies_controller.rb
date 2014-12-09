class Admin::AgenciesController < AdminController
  before_action :find_agency, only: [:edit, :update, :show]
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
  end

  def update
    if @agency.update(agency_params)
      redirect_to agency_path(@agency)
    else
      render :edit
    end
  end

  def show
    @admins = User.find_agency_admins(@agency)
  end

  def index
    @agencies = Agency.all
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

  def find_agency
    @agency = Agency.find(params[:id])
  end
end
