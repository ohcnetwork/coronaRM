class CreateSymptoms < ActiveRecord::Migration[6.0]
  def change
    create_table :symptoms do |t|
      t.belongs_to :contact, null: false, foreign_key: true
      t.string :symptom_type

      t.timestamps
    end
  end
end
