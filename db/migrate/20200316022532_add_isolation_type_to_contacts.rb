class AddIsolationTypeToContacts < ActiveRecord::Migration[6.0]
  def change
    change_table :contacts do |t|
      t.string :isolation_type
    end
  end
end
