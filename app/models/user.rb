class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum role: { client: 0, project_manager: 1 }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
