class AdminController < ApplicationController
  before_action :require_super_admin

  def require_super_admin
    unless current_user.super_admin?
      redirect_to root_path
    end
  end
end
