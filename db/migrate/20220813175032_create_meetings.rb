class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :subject
      t.datetime :start_date
      t.string :event_uid

      t.timestamps
    end
    add_index :meetings, :event_uid, unique: true
  end
end
