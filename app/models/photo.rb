class Photo < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 30 }

  belongs_to :user

  has_one_attached :image
end