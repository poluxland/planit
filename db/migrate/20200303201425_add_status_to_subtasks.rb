class AddStatusToSubtasks < ActiveRecord::Migration[6.0]
  def change
    add_column :subtasks, :status, :boolean, default: false
  end
end
