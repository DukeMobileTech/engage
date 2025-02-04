class CreateSectionDemographics < ActiveRecord::Migration[8.0]
  def change
    create_table :section_participant_responses do |t|
      t.belongs_to :section_participant, null: false, foreign_key: true
      t.belongs_to :response, null: false, foreign_key: true

      t.timestamps
    end
    remove_column :responses, :section_id, :integer
  end
end
