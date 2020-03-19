class AddIsMedicalWorkerToFlightDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :flight_details, :is_health_worker, :boolean
  end
end
