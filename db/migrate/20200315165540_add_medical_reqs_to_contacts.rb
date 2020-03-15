class AddMedicalReqsToContacts < ActiveRecord::Migration[6.0]
  def change
    change_table :contacts do |t|
      t.boolean :need_medicines
      t.boolean :ongoing_dialysis
      t.boolean :ongoing_cancer_chemo_radio_therapy
      t.string :med_other
    end
  end
end
