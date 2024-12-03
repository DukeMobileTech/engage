class CreateCurriculums < ActiveRecord::Migration[8.0]
  def change
    create_table :curriculums do |t|
      t.string :title

      t.timestamps
    end

    create_table :lessons do |t|
      t.string :title
      t.string :duration
      t.text :content
      t.references :curriculum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
