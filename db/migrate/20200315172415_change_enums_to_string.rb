class ChangeEnumsToString < ActiveRecord::Migration[6.0]
  def change
    change_column :contacts, :sex, :string
    change_column :contacts, :district, :string
    change_column :contacts, :risk, :string
    change_column :contacts, :tracking_type, :string
  end
end
