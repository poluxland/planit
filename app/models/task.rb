class Task < ApplicationRecord
  belongs_to :trip
  has_many :subtasks, dependent: :delete_all
end
