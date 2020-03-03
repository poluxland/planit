class RemoveStatusFromSubtasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :subtasks, :status
  end
end
