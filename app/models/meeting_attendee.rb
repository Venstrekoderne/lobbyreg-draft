class MeetingAttendee < ApplicationRecord
  belongs_to :email
  belongs_to :person
  belongs_to :organization
end
