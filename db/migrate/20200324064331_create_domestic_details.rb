class CreateDomesticDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :domestic_details do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.date :date_of_arrival
      t.string :place_of_departure
      t.string :mode_of_transport
      t.string :transport_detail

      t.timestamps
    end
  end
end
