require "test_helper"
require "securerandom"

class MeetingControllerTest < ActionDispatch::IntegrationTest
  test "creating a new meeting works" do
    uuid = SecureRandom.uuid
    meeting = Meeting.new(
      subject: "Test subject",
      start_date: DateTime.new,
      end_date: DateTime.new,
      event_uid: uuid
    )
    assert meeting.save
  end
end
