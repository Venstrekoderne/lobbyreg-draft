class MeetingAttendee < ApplicationRecord
  belongs_to :meeting
  belongs_to :email
  belongs_to :person
  belongs_to :organization
end
