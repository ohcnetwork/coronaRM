class RenameSexToGenderInContacts < ActiveRecord::Migration[6.0]
  def change
    rename_column :contacts, :sex, :gender
  end
end
