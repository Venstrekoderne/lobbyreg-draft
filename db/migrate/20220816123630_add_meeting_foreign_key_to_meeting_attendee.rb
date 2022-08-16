class AddMeetingForeignKeyToMeetingAttendee < ActiveRecord::Migration[7.0]
  def change
    add_column :meeting_attendees, :meeting_id, :integer
    add_foreign_key :meeting_attendees, :meetings
  end
end
