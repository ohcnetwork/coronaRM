class AddIsNotifiedCountryToFlightDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :flight_details, :is_notified_country, :boolean
  end
end
