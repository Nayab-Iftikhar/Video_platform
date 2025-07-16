class Project < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :project_manager, class_name: "User"

  has_many :videos, dependent: :destroy

  enum :status,
    pending: "pending",
    in_progress: "in_progress",
    completed: "completed"

  validates :name, :status, :footage_url, presence: true
end
