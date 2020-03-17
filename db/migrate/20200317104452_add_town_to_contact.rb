class AddTownToContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :town, :string
    add_column :contacts, :phc_name, :string
  end
end
