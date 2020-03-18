class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  def create
    super do
      resource.district = @current_user.district
      resource.save
    end
  end

  private
  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:alert] = "Access Denied! Only Admins are Allowed Access"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end

  def after_sign_up_path_for(resource)
    new_user_registration_path
  end
end
