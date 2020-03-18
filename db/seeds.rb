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
DISTRICTS_IN_KERALA.each do |district|
  District.create({name: district.titleize})
end

# Check if Date is Valid
def valid_date_or_empty_string(date)
  date_format = '%m/%d/%Y'
  date = DateTime.strptime(date, date_format)
  date
rescue ArgumentError
  nil
end

def populate_from_data_file
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

populate_from_data_file()
