class NonMedicalReqsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @non_medical_req = @contact.non_medical_reqs.create(non_medical_req_params)
   # @non_medical_req.user_id = current_user.id

    if @non_medical_req.save
      redirect_to @contact
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  private

  def non_medical_req_params
    params[:non_medical_req].permit(:requirement_type, :fullfilled)
  end
end
