class CreateTransmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :transmissions do |t|
      t.integer :contact_id
      t.integer :primary_contact_id

      t.timestamps
    end
  end
end
