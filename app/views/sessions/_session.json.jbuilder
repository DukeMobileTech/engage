json.extract! session, :id, :done_on, :section_id, :lesson_id, :created_at, :updated_at
json.url session_url(session, format: :json)
