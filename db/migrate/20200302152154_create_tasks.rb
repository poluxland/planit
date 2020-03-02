class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :status
      t.string :tip

      t.timestamps
    end
  end
end
