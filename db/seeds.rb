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
  date = date.change(:year => Time.now.year)
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
  CSV.foreach(Rails.root.join('data/initial_6.csv'), headers: true) do |row|
    contact = Contact.create({
                     name: row[0],
                     age: row[1],
                     gender: row[2] ? (row[2].first.downcase == 'm' ? :male : :female) : nil,
                     phone: row[3],
                     house_name: row[4],
                     ward: row[5],
                     panchayath: row[6],
                     isolation_type: "home_isolation",
                     passenger_type: "domestic_passenger",
                     district_id: District.find_by(name: "Pathanamthitta").id
                   })
    domestic = contact.build_domestic_detail({
                                             date_of_arrival: valid_date_or_empty_string(row[7] ? row[7] : "", "%d/%m/%Y") || valid_date_or_empty_string(row[7] ? row[7] : "", "%d.%m.%Y"),
                                             place_of_departure: row[8],
                                             mode_of_transport: row[9] ? (row[9].first.downcase == 't' ? :train : row[9].first.downcase == 'f' ? :domestic_flight : nil) : nil,
                                         })
    domestic.save!
  end
end

create_districts()
