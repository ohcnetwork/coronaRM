class CreateNonMedicalReqs < ActiveRecord::Migration[6.0]
  def change
    create_table :non_medical_reqs do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.integer :requirement_type
      t.string :other_requirement
      t.boolean :fullfilled

      t.timestamps
    end
  end
end
