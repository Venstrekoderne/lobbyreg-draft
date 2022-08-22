class MeetingAttendee < ApplicationRecord
  belongs_to :meeting
  belongs_to :email
  belongs_to :person
  belongs_to :organization

  def test
    if person_id > 2
      errors.add(:person, "Id should be above 2")
    end
  end
end
