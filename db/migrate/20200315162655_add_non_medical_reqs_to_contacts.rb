class AddNonMedicalReqsToContacts < ActiveRecord::Migration[6.0]
  def change
    change_table :contacts do |t|
      t.boolean :need_food
      t.boolean :need_drinking_water
      t.boolean :need_household_water
      t.boolean :need_sanitary_napkins
      t.boolean :need_baby_foods
      t.string :non_med_other
    end
  end
end
