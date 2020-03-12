class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :trips

  validates :name, presence: true, uniqueness: true
end
