require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post contacts_url, params: { contact: { age: @contact.age, district: @contact.district, house_name: @contact.house_name, landmark: @contact.landmark, name: @contact.name, panchayath: @contact.panchayath, patient_id: @contact.patient_id, phone: @contact.phone, previous_medical: @contact.previous_medical, risk: @contact.risk, sex: @contact.sex, symptoms: @contact.symptoms, ward: @contact.ward } }
    end

    assert_redirected_to contact_url(Contact.last)
  end

  test "should show contact" do
    get contact_url(@contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_contact_url(@contact)
    assert_response :success
  end

  test "should update contact" do
    patch contact_url(@contact), params: { contact: { age: @contact.age, district: @contact.district, house_name: @contact.house_name, landmark: @contact.landmark, name: @contact.name, panchayath: @contact.panchayath, patient_id: @contact.patient_id, phone: @contact.phone, previous_medical: @contact.previous_medical, risk: @contact.risk, sex: @contact.sex, symptoms: @contact.symptoms, ward: @contact.ward } }
    assert_redirected_to contact_url(@contact)
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete contact_url(@contact)
    end

    assert_redirected_to contacts_url
  end
end
