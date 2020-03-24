class DomesticDetailsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @domestic_detail = @contact.build_domestic_detail(domestic_detail_params)
    # @previous_medical_condition.user_id = current_user.id

    if @domestic_detail.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Domestic Details were Added Successfully' }
      end
    else
      flash.now[:alert] = 'There was an error saving the Domestic Detail, Contact Your Admin'
    end
  end

  def update
    domestic_detail = DomesticDetail.find(params[:id])
    contact = Contact.find(params[:contact_id])
    respond_to do |format|
      if domestic_detail.update(domestic_detail_params)
        format.html { redirect_to contact, notice: 'Domestic Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def domestic_detail_params
    params[:domestic_detail].permit(:date_of_arrival, :mode_of_transport, :place_of_departure, :transport_detail)
  end
end
