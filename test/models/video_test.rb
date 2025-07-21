require "test_helper"

class VideoTest < ActiveSupport::TestCase
  def setup
    @client = users(:one)
    @pm = users(:two)
    @project = Project.create!(
      name: "Test Project",
      status: "in_progress",
      footage_url: "http://example.com/footage.mp4",
      client: @client,
      project_manager: @pm
    )
    @video_type = VideoType.create!(name: "Type", price: 100, format: "MP4", descrption: "Description", video_url: "http://example.com/video.mp4")
    @video = Video.new(
      name: "Test Video",
      project: @project,
      video_type: @video_type,
    )
  end

  test "valid video" do
    assert @video.valid?
  end

  test "invalid without name" do
    @video.name = nil
    assert_not @video.valid?
    assert_includes @video.errors[:name], "can't be blank"
  end

  test "invalid without project" do
    @video.project = nil
    assert_not @video.valid?
    assert_includes @video.errors[:project], "must exist"
  end

  test "invalid without video_type" do
    @video.video_type = nil
    assert_not @video.valid?
    assert_includes @video.errors[:video_type], "must exist"
  end

  test "belongs to project and video_type" do
    assert_equal @project, @video.project
    assert_equal @video_type, @video.video_type
  end
end
