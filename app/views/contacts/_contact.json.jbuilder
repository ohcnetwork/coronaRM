json.extract! contact, :id, :name, :patient_id, :phone, :age, :sex, :house_name, :ward, :panchayath, :landmark, :district, :risk, :previous_medical, :symptoms, :created_at, :updated_at
json.url contact_url(contact, format: :json)
