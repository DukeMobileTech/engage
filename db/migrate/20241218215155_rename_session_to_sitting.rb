class RenameSessionToSitting < ActiveRecord::Migration[8.0]
  def change
    rename_table :sessions, :sittings
    rename_column :attendances, :session_id, :sitting_id
    rename_index :attendances, 'index_attendances_on_session_id', 'index_attendances_on_sitting_id' if index_exists?(:attendances, :session_id)
    rename_index :attendances, 'index_attendances_on_session_id_and_participant_id', 'index_attendances_on_sitting_id_and_participant_id' if index_exists?(:attendances, [ :session_id, :participant_id ])
    rename_column :responses, :session_id, :sitting_id
    rename_index :responses, 'index_responses_on_session_id', 'index_responses_on_sitting_id' if index_exists?(:responses, :session_id)
  end
end
