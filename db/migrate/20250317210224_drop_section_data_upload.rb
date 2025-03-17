class DropSectionDataUpload < ActiveRecord::Migration[8.0]
  def change
    drop_table :section_data_uploads do |t|
      t.references :section, null: false, foreign_key: true
      t.references :data_upload, null: false, foreign_key: true

      t.timestamps
    end
  end
end
