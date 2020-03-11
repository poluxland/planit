class Trip < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user, optional: true
  has_one_attached :photo

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Validation
  validates :name,  presence: :true
  validates :description,  presence: :true
  validates :location, presence: :true

  before_validation :assign_unique_code

  validates! :code, uniqueness: true


  CODE = (100_000_000..999_999_999)

  def assign_unique_code
    self.code = loop do
      code = rand(CODE)
      break code unless Trip.exists?(code: code)

    end
  end

  def photo_key
    if self.photo.attached?
      self.photo.key
    else
      "trip"
    end
  end


  def number_of_tasks_completed
    self.tasks.where(status: true).count
  end

  def number_of_tasks
    self.tasks.count
  end

  def number_of_tasks_to_do
    number_of_tasks - number_of_tasks_completed
  end

  def number_of_subtasks_completed
    Subtask.where(task_id: Task.where(trip_id: self.id), status: true).count
  end

  def number_of_subtasks
    Subtask.where(task_id: Task.where(trip_id: self.id)).count
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
