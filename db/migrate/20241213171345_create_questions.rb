class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.belongs_to :questionnaire, null: false, foreign_key: true
      t.text :text
      t.string :identifier, null: false, index: { unique: true }
      t.integer :question_type
      t.integer :number
      t.boolean :required, default: true

      t.timestamps
    end
  end
end
