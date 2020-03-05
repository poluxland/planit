class AddTemporaryTripToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :session, :boolean, default: false
  end
end
