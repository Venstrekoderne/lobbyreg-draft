class CreateMeetingAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :meeting_attendees do |t|
      t.references :email, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
