class Video < ApplicationRecord
  belongs_to :project
  belongs_to :video_type

  validates :name, presence: true
end
