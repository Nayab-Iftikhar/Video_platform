class VideoType < ApplicationRecord
  has_many :videos, dependent: :destroy
  
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :format, presence: true
end
