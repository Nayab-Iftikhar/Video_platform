require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  def setup
    @client = User.create!(name: "Client", email_address: "client@example.com", password: "password", role: :client)
    @pm = User.create!(name: "PM", email_address: "pm@example.com", password: "password", role: :project_manager)
    @project = Project.create!(
      name: "Test Project",
      status: "in_progress",
      footage_url: "http://example.com/footage.mp4",
      client: @client,
      project_manager: @pm
    )
  end

  test "valid project" do
    assert @project.valid?
  end

  test "invalid without name" do
    @project.name = nil
    assert_not @project.valid?
    assert_includes @project.errors[:name], "can't be blank"
  end

  test "invalid without status" do
    @project.status = nil
    assert_not @project.valid?
    assert_includes @project.errors[:status], "can't be blank"
  end

  test "invalid with invalid status" do
    assert_raises(ArgumentError) do
      @project.status = "non_existent_status"
    end
  end

  test "invalid without footage_url" do
    @project.footage_url = nil
    assert_not @project.valid?
    assert_includes @project.errors[:footage_url], "can't be blank"
  end

  test "belongs to client and project_manager" do
    assert_equal @client, @project.client
    assert_equal @pm, @project.project_manager
  end

  test "project manager association" do
    assert_equal @pm.id, @project.project_manager.id
    assert_equal @client.id, @project.client.id
  end

  test "status enum values" do
    assert_includes Project.statuses.keys, "pending"
    assert_includes Project.statuses.keys, "in_progress"
    assert_includes Project.statuses.keys, "completed"
  end

  test "project status is set correctly" do
    project = Project.new(name: "New Project", footage_url: "http://example.com", status: "in_progress")
    assert_equal "in_progress", project.status
  end

  test "dependent destroy videos" do
    @project.save!
    video_type = VideoType.create!(name: "Type", price: 100, format: "MP4", descrption: "Description", video_url: "http://example.com/video.mp4")
    video = @project.videos.create!(name: "Test Video", video_type: video_type)
    assert_difference("Video.count", -1) do
      @project.destroy
    end
  end

  test "valid project with selected video types" do
    video_type = VideoType.create!(name: "Test Video", price: 50, format: "MP4", descrption: "Description", video_url: "http://example.com/video.mp4")
    @project.save!
    @project.videos.create!(video_type: video_type, name: "Test Video")
    assert_equal 1, @project.videos.count
  end
end
