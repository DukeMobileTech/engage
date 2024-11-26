class CreateSites < ActiveRecord::Migration[8.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :code, null: false, index: { unique: true }
      t.string :state
      t.string :county
      t.string :urbanicity
      t.string :setting

      t.timestamps
    end
  end
end
