class AddMedNonMedsBeingMetToContacts < ActiveRecord::Migration[6.0]
  def change
    change_table :contacts do |t|
      t.boolean :is_non_med_req_met
      t.boolean :is__med_req_met
      t.text :comment
    end
  end
end
