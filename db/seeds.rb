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
def valid_date_or_empty_string(date, format)
  date = DateTime.strptime(date,format)
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
                      date_of_first_contact: valid_date_or_empty_string(row[16] ? row[16] : "", "%d/%m/%Y") || valid_date_or_empty_string(row[16] ? row[16] : "", "%d.%m.%Y"),
                      mode_of_contact: row[19],
                      risk: row[20]&.first&.downcase == 'h' ? :high : :low
                    })
  end
end


def populate_traveller_from_data_file
  CSV.foreach(Rails.root.join('data/import_4.csv'), headers: true) do |row|
    contact = Contact.create({
                     name: row[0],
                     age: row[2],
                     gender: row[3] ? (row[3].first.downcase == 'm' ? :male : :female) : nil,
                     phone: row[4],
                     house_name: row[5],
                     ward: row[6],
                     panchayath: row[7],
                     profession: row[10],
                     isolation_type: "home_isolation",
                     passenger_type: "domestic_passenger",
                     district_id: District.find_by(name: "Pathanamthitta").id
                   })
    domestic = contact.build_domestic_detail({
                                             date_of_arrival: valid_date_or_empty_string(row[1] ? row[1] : "", "%d/%m/%Y") || valid_date_or_empty_string(row[1] ? row[1] : "", "%d.%m.%Y"),
                                             place_of_departure: row[8],
                                             mode_of_transport: row[9] ? (row[9].first.downcase == 't' ? :train : "") : nil,
                                         })
    domestic.save!
  end
end

populate_traveller_from_data_file()
