class AddLessonsCoveredToSection < ActiveRecord::Migration[8.0]
  def change
    add_column :sections, :lessons_covered, :integer, default: 1, null: false
  end
end
