class DashboardController < ApplicationController
  before_action :authenticate_user!, :redirect_unless_admin 

  def index
    @contacts_count = Contact.all.count()
    @primary_contacts_count  = Contact.where(tracking_type: :primary).count
    @secondary_contacts_count  = Contact.where(tracking_type: :secondary).count

    @number_of_contacts_contacted_today = Contact.joins(:calls).where(calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
    @number_of_primary_contacted_today = Contact.joins(:calls).where(tracking_type: :primary,calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
    @number_of_secondary_contacted_today = Contact.joins(:calls).where(tracking_type: :secondary, calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
  end

  def generate_csv_report
    @contacts = Contact.all()
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_csv_called_report
    @contacted_today = Contact.joins(:calls).where(calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data @contacted_today.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  private
  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:alert] = "Access Denied! Only Admins are Allowed Access"
      redirect_to root_path
    end
  end
end
