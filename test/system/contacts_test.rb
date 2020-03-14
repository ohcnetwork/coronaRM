require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    @contact = contacts(:one)
  end

  test "visiting the index" do
    visit contacts_url
    assert_selector "h1", text: "Contacts"
  end

  test "creating a Contact" do
    visit contacts_url
    click_on "New Contact"

    fill_in "Age", with: @contact.age
    fill_in "District", with: @contact.district
    fill_in "House name", with: @contact.house_name
    fill_in "Landmark", with: @contact.landmark
    fill_in "Name", with: @contact.name
    fill_in "Panchayath", with: @contact.panchayath
    fill_in "Patient", with: @contact.patient_id
    fill_in "Phone", with: @contact.phone
    fill_in "Previous medical", with: @contact.previous_medical
    fill_in "Risk", with: @contact.risk
    fill_in "Sex", with: @contact.sex
    fill_in "Symptoms", with: @contact.symptoms
    fill_in "Ward", with: @contact.ward
    click_on "Create Contact"

    assert_text "Contact was successfully created"
    click_on "Back"
  end

  test "updating a Contact" do
    visit contacts_url
    click_on "Edit", match: :first

    fill_in "Age", with: @contact.age
    fill_in "District", with: @contact.district
    fill_in "House name", with: @contact.house_name
    fill_in "Landmark", with: @contact.landmark
    fill_in "Name", with: @contact.name
    fill_in "Panchayath", with: @contact.panchayath
    fill_in "Patient", with: @contact.patient_id
    fill_in "Phone", with: @contact.phone
    fill_in "Previous medical", with: @contact.previous_medical
    fill_in "Risk", with: @contact.risk
    fill_in "Sex", with: @contact.sex
    fill_in "Symptoms", with: @contact.symptoms
    fill_in "Ward", with: @contact.ward
    click_on "Update Contact"

    assert_text "Contact was successfully updated"
    click_on "Back"
  end

  test "destroying a Contact" do
    visit contacts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contact was successfully destroyed"
  end
end
