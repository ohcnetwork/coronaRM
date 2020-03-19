class AddNotReachableToCalls < ActiveRecord::Migration[6.0]
  def change
    add_column :calls, :not_reachable, :boolean
  end
end
