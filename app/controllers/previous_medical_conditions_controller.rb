class PreviousMedicalConditionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @previous_medical_condition = @contact.previous_medical_conditions.create(previous_medical_condition_params)
   # @previous_medical_condition.user_id = current_user.id

    if @previous_medical_condition.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Previous Medical Condition was Added Successfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Non Medical Requirement, Contact Your Admin'
    end
  end

  private

  def previous_medical_condition_params
    params[:previous_medical_condition].permit(:condition_type, :fullfilled)
  end
end
