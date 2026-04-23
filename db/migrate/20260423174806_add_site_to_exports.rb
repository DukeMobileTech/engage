class AddSiteToExports < ActiveRecord::Migration[8.0]
  def change
    add_column :data_uploads, :include_site, :boolean, default: false
    add_column :sections, :period, :string
  end
end
