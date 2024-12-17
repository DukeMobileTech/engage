class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.belongs_to :questionnaire, null: false, foreign_key: true
      t.belongs_to :participant, null: true, foreign_key: true
      t.belongs_to :session, null: true, foreign_key: true
      t.json :answers

      t.timestamps
    end
  end
end
