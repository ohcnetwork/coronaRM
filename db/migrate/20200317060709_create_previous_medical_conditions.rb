class CreatePreviousMedicalConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :previous_medical_conditions do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.string :condition_type

      t.timestamps
    end
  end
end
