class Admin::UsersController < AdminController
  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)
    @user.make_agency_admin
    if @user.save
      flash[:notice] = "Admin successfully created."
      redirect_to admin_agency_path(params[:agency_id])
    else
      flash[:notice] = "Admin creation was unsuccessful."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password
    ).merge(agency_id: params[:agency_id])
  end
end
