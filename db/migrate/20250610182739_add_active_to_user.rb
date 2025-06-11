class AddActiveToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :active, :boolean, default: false
  end
end
