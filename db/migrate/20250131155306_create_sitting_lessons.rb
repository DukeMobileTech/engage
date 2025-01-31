class CreateSittingLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :sitting_lessons do |t|
      t.belongs_to :lesson, null: false, foreign_key: true
      t.belongs_to :sitting, null: false, foreign_key: true

      t.timestamps
    end
    remove_column :sittings, :lesson_id
  end
end
