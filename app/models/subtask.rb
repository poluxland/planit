class Subtask < ApplicationRecord
  belongs_to :task

  # Validation
  validates :name,  presence: :true
  validates :description,  presence: :true
end
