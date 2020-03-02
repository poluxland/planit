class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :trips

  def avatar_key
    if self.avatar.attached?
      self.avatar.key
    else
      "avatar"
    end
  end
end
