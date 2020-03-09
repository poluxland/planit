class Task < ApplicationRecord
  belongs_to :trip
  has_many :subtasks, dependent: :delete_all

  # Validation
  validates :name,  presence: :true
  validates :description,  presence: :true

  def number_of_subtasks_completed
    # Subtask.where(task_id: Task.where(trip_id: self.trip.id), status: true).count
    self.subtasks.where(status: true).count
  end

  def number_of_subtasks
    # Subtask.where(task_id: Task.where(trip_id: self.id)).count
    self.subtasks.count
  end

  def number_of_subtasks_to_do
    number_of_subtasks - number_of_subtasks_completed
  end

  def completion
    if self.number_of_subtasks.zero?
      progress = 0
    else
      progress = self.number_of_subtasks_completed * 100 / self.number_of_subtasks
    end
  end
end
