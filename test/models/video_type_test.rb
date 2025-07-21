require "test_helper"

class VideoTypeTest < ActiveSupport::TestCase
  def setup
    @video_type = VideoType.new(
      name: "Highlight Reel",
      price: 500,
      format: "MP4",
      descrption: "Description",
      video_url: "http://example.com/video.mp4"
    )
  end

  test "valid video_type" do
    assert @video_type.valid?
  end

  test "invalid without name" do
    @video_type.name = nil
    assert_not @video_type.valid?
    assert_includes @video_type.errors[:name], "can't be blank"
  end

  test "invalid without format" do
    @video_type.format = nil
    assert_not @video_type.valid?
    assert_includes @video_type.errors[:format], "can't be blank"
  end

  test "invalid with negative price" do
    @video_type.price = -10
    assert_not @video_type.valid?
    assert_includes @video_type.errors[:price], "must be greater than or equal to 0"
  end

  test "has many videos and dependent destroy" do
    @video_type.save!
    client = users(:one)
    pm = users(:two)
    project = Project.create!(
      name: "Test Project",
      status: "in_progress",
      footage_url: "http://example.com/footage.mp4",
      client: client,
      project_manager: pm
    )
    video = @video_type.videos.create!(name: "Test Video", project: project)
    assert_difference("Video.count", -1) do
      @video_type.destroy
    end
  end
end
