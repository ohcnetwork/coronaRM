class SymptomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @contact = Contact.find(params[:contact_id])
    @symptom = @contact.symptoms.create(symptom_params)
    # @symptom.user_id = current_user.id

    if @symptom.save
      respond_to do |format|
        format.html { redirect_to @contact, notice: 'Symptom was Added Succesfully' }
      end
    else
      flash.now[:danger] = 'There was an error saving the Symptom, Contact Your Admin'
    end
  end

  private

  def symptom_params
    params[:symptom].permit(:symptom_type, :fullfilled)
  end
end
