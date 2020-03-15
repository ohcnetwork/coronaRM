class ChangePreviousSymptomsToText < ActiveRecord::Migration[6.0]
  def change
      change_column :contacts, :previous_medical, :string
      change_column :contacts, :symptoms, :string
  end
end
