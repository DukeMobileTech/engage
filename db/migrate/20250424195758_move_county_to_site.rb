class MoveCountyToSite < ActiveRecord::Migration[8.0]
  def change
    add_column :sites, :county, :string
    remove_column :organizations, :county, :string
  end
end
