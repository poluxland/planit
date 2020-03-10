class AddColumnsToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :max_temp, :integer
    add_column :trips, :min_temp, :integer
    add_column :trips, :precipitation, :float
  end
end
