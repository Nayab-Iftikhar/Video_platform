# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

video_types = VideoType.create!([
  { name: "Highlight Reel", price: 500, format: "MP4" },
  { name: "Documentary Edit", price: 1000, format: "MOV" },
  { name: "Teaser", price: 300, format: "MP4" },
  { name: "Social Media Clip", price: 200, format: "MP4" }
])
puts "Created #{video_types.count} video types."


puts "Seeding users..."

# Project Managers
pms = User.create!([
  { name: "Sabaina Manager", email_address: "sabaina@example.com", password: "password", password_confirmation: "password", role: :project_manager },
  { name: "John Manager", email_address: "john@example.com", password: "password", password_confirmation: "password", role: :project_manager },
  { name: "Charlie Manager", email_address: "charlie@example.com", password: "password", password_confirmation: "password", role: :project_manager }
])

# Clients
clients = User.create!([
  { name: "David Client", email_address: "david@example.com", password: "password", password_confirmation: "password", role: :client },
  { name: "Eva Client", email_address: "eva@example.com", password: "password", password_confirmation: "password", role: :client },
  { name: "Frank Client", email_address: "frank@example.com", password: "password", password_confirmation: "password", role: :client }
])

puts "Created #{pms.count} PMs and #{clients.count} clients."

puts "Seeding projects and videos..."

10.times do |i|
  client = clients.sample
  pm = pms.sample

  project = Project.create!(
    name: "Project #{i + 1}",
    footage_url: "https://example.com/raw_footage/#{i + 1}",
    client: client,
    project_manager: pm,
    status: "in_progress"
  )

  rand(1..3).times do |j|
    type = video_types.sample
    Video.create!(
      name: "Video #{j + 1} for Project #{project.id}",
      project: project,
      video_type: type
    )
  end
end

puts "Seeding completed!"