class AddCodeToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :code, :integer
  end
end
