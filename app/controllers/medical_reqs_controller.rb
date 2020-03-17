class MedicalReqsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @medical_req = @contact.medical_reqs.create(medical_req_params)
   # @medical_req.user_id = current_user.id

    if @medical_req.save
      redirect_to @contact
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def fullfill
    @medical_req = MedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])
    @medical_req.fullfilled = true

    if @medical_req.save
      redirect_to @contact
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  def destroy
    @medical_req = MedicalReq.find(params[:id])
    @contact = Contact.find(params[:contact_id])

    @medical_req.destroy
    respond_to do |format|
      format.html { redirect_to @contact, notice: 'Request was succesfully cancelled' }
      format.json { head :no_content }
    end
  end

  private

  def medical_req_params
    params[:medical_req].permit(:requirement_type, :fullfilled)
  end
end
