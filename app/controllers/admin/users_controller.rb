class Admin::UsersController < AdminController
  def create
    @user = sign_up(user_params)
    @user.make_agency_admin
    if @user.save
      redirect_to admin_agency_path(user_params[:agency_id])
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :agency_id)
  end
end
