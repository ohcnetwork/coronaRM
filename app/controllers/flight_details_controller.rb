class FlightDetailsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @flight_detail = @contact.build_flight_detail(flight_detail_params)
    # @previous_medical_condition.user_id = current_user.id

    if @flight_detail.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Flight Details were Added Successfully' }
      end
    else
      flash.now[:alert] = 'There was an error saving the Flight Detail, Contact Your Admin'
    end
  end

  def update
    flight_detail = FlightDetail.find(params[:id])
    contact = Contact.find(params[:contact_id])
    respond_to do |format|
      if flight_detail.update(flight_detail_params)
        format.html { redirect_to contact, notice: 'Flight Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def flight_detail_params
    params[:flight_detail].permit(:date_of_arrival, :flight_number, :arrival_airport, :departure_country, :profession, :connecting_flight_details, :is_health_worker)
  end
end
