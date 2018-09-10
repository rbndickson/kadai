class Photo < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 30 }
end