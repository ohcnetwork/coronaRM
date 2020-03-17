class RemoveSymptomsFromContact < ActiveRecord::Migration[6.0]
  def change
    remove_column :contacts, :symptoms
  end
end
