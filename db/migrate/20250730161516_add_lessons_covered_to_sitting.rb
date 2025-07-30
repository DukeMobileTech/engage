class AddLessonsCoveredToSitting < ActiveRecord::Migration[8.0]
  def change
    add_column :sittings, :lessons_covered, :string, array: true, default: []
  end
end
