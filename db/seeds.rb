puts "Creating Video types..."
video_types = VideoType.create!([
  { 
    name: "Highlight Reel", 
    price: 500, 
    format: "MP4", 
    descrption: "Create the Highlights for the Social Media platforms", 
    video_url: "https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.webm" 
  },
  { 
    name: "Documentary Edit", 
    price: 1000, 
    format: "MOV",
    descrption: "Full-length documentary style edit for storytelling",
    video_url: "https://sample-videos.com/video123/mov/720/big_buck_bunny_720p_1mb.mov"
  },
  { 
    name: "Teaser", 
    price: 300, 
    format: "MP4",
    descrption: "Short teaser to build anticipation",
    video_url: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
  },
  { 
    name: "Social Media Clip", 
    price: 200, 
    format: "MP4",
    descrption: "Quick clips optimized for social media sharing",
    video_url: "https://www.w3schools.com/html/mov_bbb.mp4"
  }
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