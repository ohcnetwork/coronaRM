# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Load the patient Data
require 'csv'


DISTRICTS_IN_KERALA = %w[alappuzha ernakulam idukki kannur kasargod kollam kottayam kozhikode malappuram palakkad pathanamthitta thiruvananthapuram thrissur wayanad].freeze

def create_districts
  DISTRICTS_IN_KERALA.each do |district|
    District.create({name: district.titleize})
  end
end

# Check if Date is Valid
def valid_date_or_empty_string(date)
  date_format = '%m/%d/%Y'
  date = DateTime.strptime(date, date_format)
  date
rescue ArgumentError
  nil
end

def populate_patients_from_data_file
    CSV.foreach(Rails.root.join('data/initial_data.csv'), headers: true) do |row|
      Contact.create({
                      patient_id: row[0] ,
                      name: row[1],
                      tracking_type: :primary,
                      gender: row[8].first.downcase == 'm' ? :male : :female,
                      age: row[9],
                      phc_name: row[10],
                      house_name: row[11],
                      town: row[12],
                      district_id: District.find_by(name: row[13].titleize.strip).id,
                      phone: row[14],
                      date_of_first_contact: valid_date_or_empty_string(row[16] ? row[16] : ""),
                      mode_of_contact: row[19],
                      risk: row[20]&.first&.downcase == 'h' ? :high : :low
                    })
  end
end


def populate_traveller_from_data_file
  contacts = []
  CSV.foreach(Rails.root.join('data/traveller.csv'), headers: true) do |row|
    Contact.create({
                     name: row[0],
                     phone: row[1],
                     house_name: row[2],
                     ward: row[3],
                     panchayath: row[4],
                     phc_name: row[6],
                     field_staff_name: row[7],
                     field_staff_phone: row[8],
                     tracking_type: "flight_passenger",
                     district_id: District.find_by(name: "Pathanamthitta").id
                   })
  end
  CSV.foreach(Rails.root.join('data/traveller.csv'), headers: true) do |row|
    contact = Contact.find_by(name: row[0], phone: row[1])
    flight = contact.flight_detail || contact.build_flight_detail({
                                  arrival_airport: row[5],
                                  contact_id: contact.id
                                })
    flight.save!
  end
end

create_districts
populate_traveller_from_data_file()
