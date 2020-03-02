class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :location
      t.date :start_date
      t.date :end_date
      t.string :gender
      t.integer :age
      t.string :origin
      t.string :purpose

      t.timestamps
    end
  end
end

