class AddDistrictToContact < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :district, foreign_key: true
  end
end
