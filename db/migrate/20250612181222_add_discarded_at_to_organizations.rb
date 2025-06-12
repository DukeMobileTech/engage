class AddDiscardedAtToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :discarded_at, :datetime
    add_index :organizations, :discarded_at
  end
end
