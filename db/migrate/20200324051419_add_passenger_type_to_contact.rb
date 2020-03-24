class AddPassengerTypeToContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :passenger_type, :string
  end
end
