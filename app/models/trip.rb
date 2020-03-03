class Trip < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  belongs_to :user, optional: true
  has_one_attached :photo

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Validation
  validates :name,  presence: :true
  validates :description,  presence: :true
  validates :location, presence: :true

  def photo_key
    if self.photo.attached?
      self.photo.key
    else
      "trip"
    end
  end
end
