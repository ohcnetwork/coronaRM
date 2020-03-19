class DropPatientIdIndexFromContact < ActiveRecord::Migration[6.0]
  def change
    remove_index :contacts, name: "index_contacts_on_patient_id"
  end
end
