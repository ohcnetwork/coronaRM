class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  private
  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:error] = "Only Admin Access"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end
end
