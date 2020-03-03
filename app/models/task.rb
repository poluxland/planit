class Task < ApplicationRecord
  belongs_to :trip
  has_many :subtasks, dependent: :delete_all

  # Validation
  validates :name,  presence: :true
  validates :description,  presence: :true
end
