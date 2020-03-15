class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :patient_id
      t.string :phone
      t.integer :age
      t.integer :sex
      t.string :house_name
      t.integer :ward
      t.string :panchayath
      t.string :landmark
      t.integer :district
      t.integer :risk
      t.integer :previous_medical
      t.integer :symptoms

      t.timestamps
    end
    add_index :contacts, :patient_id, unique: true
  end
end
