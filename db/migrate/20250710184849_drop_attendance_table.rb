class DropAttendanceTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :attendances
  end
end
