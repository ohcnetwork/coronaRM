class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  private
  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:notice] = "Only Admin Access"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    false
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, district: [:name])
  end
end
