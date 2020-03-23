class DashboardController < ApplicationController
  before_action :authenticate_user!, :redirect_unless_admin 

  def index
    @contacts_count = Contact.all.count()
    @flight_passengers_contacts_count  = Contact.where(tracking_type: :flight_passenger).count
    @primary_contacts_count  = Contact.where(tracking_type: :primary).count
    @secondary_contacts_count  = Contact.where(tracking_type: :secondary).count

    @number_of_contacts_contacted_today = Contact.joins(:calls).where(calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
    @number_of_unreachable_contacts_contacted_today = Contact.joins(:calls).where(calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, not_reachable: true}).distinct.count
    @number_of_flight_passengers_contacted_today = Contact.joins(:calls).where(tracking_type: :flight_passenger,calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
    @number_of_primary_contacted_today = Contact.joins(:calls).where(tracking_type: :primary,calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
    @number_of_secondary_contacted_today = Contact.joins(:calls).where(tracking_type: :secondary, calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct.count
    @number_of_health_workers_flight_passengers = Contact.left_outer_joins(:flight_detail).where(tracking_type: :flight_passenger, flight_details: {is_health_worker: true}).distinct.count


    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @number_of_symptomatics_today = Contact.joins(:calls, :symptoms).where(calls:{created_at: today}).where({symptoms: {created_at: today}}).where.not(symptoms: {symptom_type: ""}).distinct.count
    @number_of_symptomatics = Contact.joins(:symptoms).where.not(symptoms: nil).where.not(symptoms: {symptom_type: ""}).distinct.count
    @number_of_non_contacted_ever = @contacts_count - Contact.joins(:calls).distinct.count
  end

  def csv_report
    @contacts = Contact.all()
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def report_travellers
    @contacts = Contact.where(tracking_type: "flight_passenger")
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def called_report_today
    @contacted_today = Contact.joins(:calls).where(calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data @contacted_today.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def not_reachable_report_today
    @contacted_today = Contact.joins(:calls).where(calls:{created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, not_reachable: true}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data @contacted_today.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def medical_needs_report_today
    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @contacted_today = Contact.joins(:calls, :medical_reqs).where(calls:{created_at: today}).where({medical_reqs: {created_at: today}}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data @contacted_today.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def non_medical_needs_report_today
    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @contacted_today = Contact.joins(:calls, :non_medical_reqs).where(calls:{created_at: today}).where({non_medical_reqs: {created_at: today}}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data @contacted_today.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def health_care_workers
    contacts = Contact.left_outer_joins(:flight_detail).where(tracking_type: :flight_passenger, flight_details: {is_health_worker: true}).distinct

    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def health_care_workers_today
    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    contacts = Contact.joins(:calls).where(calls: {created_at: today}).left_outer_joins(:flight_detail).where(tracking_type: :flight_passenger, flight_details: {is_health_worker: true}).distinct

    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def contacts_contacted
     contacts = Contact.joins(:calls).where(calls: {not_reachable: nil}).distinct

    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_symptomatic_today
    today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    contacted_today = Contact.joins(:calls, :symptoms).where(calls:{created_at: today}).where({symptoms: {created_at: today}}).where.not(symptoms: {symptom_type: ""}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data contacted_today.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_symptomatic
    contacts = Contact.joins(:symptoms).where.not(symptoms: {symptom_type: ""}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_medical_reqs
    contacts = Contact.joins(:medical_reqs).where(medical_reqs: {fullfilled: nil}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_non_medical_reqs
    contacts = Contact.joins(:non_medical_reqs).where(non_medical_reqs: {fullfilled: nil}).distinct
    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def generate_not_called_yet
    contacts = Contact.left_outer_joins(:calls).where(calls: {id: nil})
    respond_to do |format|
      format.html
      format.csv { send_data contacts.to_csv, filename: "users-#{Date.today}.csv" }
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
