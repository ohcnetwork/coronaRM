class ContactsController < ApplicationController
  load_and_authorize_resource

  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.order(patient_id: :asc)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @related_contacts = Contact.where(phone: @contact.phone).where.not(patient_id: @contact.patient_id)
    @last_call = @contact.calls.order("created_at").last
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_call
    called_user = User.find(params[:user_id])
    @contact.callees << called_user
    respond_to do |format|
      format.html { redirect_to contacts_path, notice: "Contact #{@contact.name} was successfully Called" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :patient_id, :phone, :age, :sex, :house_name, :ward, :panchayath, :landmark, :district, :risk, :previous_medical, :symptoms, :tracking_type, :infector_id, :isolation_type, :need_food, :need_baby_foods, :need_drinking_water, :need_household_water, :need_medicines, :need_sanitary_napkins, :non_med_other, :ongoing_dialysis, :ongoing_cancer_chemo_radio_therapy, :med_other, :is_med_req_met, :is_non_med_req_met, :comment)
    end
end
