class FixTypoMedReqInContacts < ActiveRecord::Migration[6.0]
  def change
    rename_column :contacts, :is__med_req_met, :is_med_req_met
  end
end
