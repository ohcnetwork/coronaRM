class CreateFlightDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :flight_details do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.date :date_of_arrival
      t.string :flight_number
      t.string :arrival_airport
      t.string :departure_country
      t.string :profession
      t.string :connecting_flight_details

      t.timestamps
    end
  end
end
