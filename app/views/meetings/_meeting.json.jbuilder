json.extract! meeting, :id, :subject, :start_date, :event_uid, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
