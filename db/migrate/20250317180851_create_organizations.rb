class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :state
      t.string :county
      t.string :urbanicity
      t.string :setting

      t.timestamps
    end
    add_column :sites, :organization_id, :integer
    add_index :sites, :organization_id
    remove_column :sites, :urbanicity, :string
    remove_column :sites, :county, :string
    remove_column :sites, :state, :string
    remove_column :sites, :setting, :string
    add_column :data_uploads, :reporting_period_start, :date
    add_column :data_uploads, :reporting_period_end, :date
  end
end
