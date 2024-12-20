class CreateSittings < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.datetime :done_on
      t.references :section, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
    add_column :sections, :completed, :boolean, default: false
    create_table :section_participants do |t|
      t.references :section, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
