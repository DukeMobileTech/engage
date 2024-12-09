class AddPresentToAttendance < ActiveRecord::Migration[8.0]
  def change
    add_column :attendances, :present, :boolean, default: false
    add_index :attendances, [ :session_id, :participant_id ], unique: true
  end
end
