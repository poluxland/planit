class Trip < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  belongs_to :user, optional: true

  # Validation
  validates :name,  presence: :true
  validates :description,  presence: :true
end
