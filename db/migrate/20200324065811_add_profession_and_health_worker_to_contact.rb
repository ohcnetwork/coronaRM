class AddProfessionAndHealthWorkerToContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :profession, :string
    add_column :contacts, :is_health_worker, :boolean
  end
end
