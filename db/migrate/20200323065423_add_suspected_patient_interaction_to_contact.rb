class AddSuspectedPatientInteractionToContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :did_meet_suspected_patient, :boolean
  end
end
