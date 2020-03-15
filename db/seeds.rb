# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Load the patient Data
require 'csv'
CSV.foreach(Rails.root.join('data/initial_data.csv'), headers: true) do |row|
  Contact.create({
                  patient_id: row[0] ,
                  name: row[1],
                  sex: row[2] && row[2] == "Male" ? :male : :female,
                  age: row[3],
                  house_name: row[4],
                  panchayath: row[5],
                  phone: row[6],
                  tracking_type: row[7] && row[7] == "Primary" ? :primary : :secondary,
                  risk: row[8] &&  row[8].downcase.include?("High") ? :high : :low
                 })
end
