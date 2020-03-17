class AddDateOfFirstContactToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :date_of_first_contact, :date
  end
end
