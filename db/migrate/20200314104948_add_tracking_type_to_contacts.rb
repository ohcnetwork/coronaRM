class AddTrackingTypeToContacts < ActiveRecord::Migration[6.0]
  def change
    change_table :contacts do |t|
      t.integer :tracking_type, :integer
    end
  end
end
