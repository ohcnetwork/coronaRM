class ChangeRoleToString < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role, :string
  end
end
