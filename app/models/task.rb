class Task < ApplicationRecord
  belongs_to :trip
  as_many :subtasks
end
