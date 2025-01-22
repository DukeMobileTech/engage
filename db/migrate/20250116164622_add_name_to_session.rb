class AddNameToSession < ActiveRecord::Migration[8.0]
  def change
    add_column :sittings, :name, :string
  end
end
