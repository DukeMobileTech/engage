class CreateLessonAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_attendances do |t|
      t.belongs_to :participant, null: false, foreign_key: true
      t.belongs_to :sitting_lesson, null: false, foreign_key: true
      t.boolean :present, default: false

      t.timestamps
    end
  end
end
