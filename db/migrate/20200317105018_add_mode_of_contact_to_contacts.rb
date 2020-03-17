class AddModeOfContactToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :mode_of_contact, :string
  end
end
