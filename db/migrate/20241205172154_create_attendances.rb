class CreateAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :attendances do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
    change_column :sections, :start_date, :date
    change_column :sections, :end_date, :date
  end
end
