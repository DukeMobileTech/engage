class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :study_id
      t.string :category, default: 'Youth'

      t.timestamps
    end

    add_index :participants, :study_id, unique: true

    create_table :site_participants do |t|
      t.references :site, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
