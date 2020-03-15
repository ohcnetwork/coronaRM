class ChangePatientIdFromIntToString < ActiveRecord::Migration[6.0]
  def change
    change_column :contacts, :patient_id, :string
  end
end
