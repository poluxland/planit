class Trip < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  belongs_to :user, optional: true

end
