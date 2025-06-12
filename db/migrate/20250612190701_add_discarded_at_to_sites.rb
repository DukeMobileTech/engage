class AddDiscardedAtToSites < ActiveRecord::Migration[8.0]
  def change
    add_column :sites, :discarded_at, :datetime
    add_index :sites, :discarded_at
    add_column :sections, :discarded_at, :datetime
    add_index :sections, :discarded_at
    add_column :sittings, :discarded_at, :datetime
    add_index :sittings, :discarded_at
  end
end
