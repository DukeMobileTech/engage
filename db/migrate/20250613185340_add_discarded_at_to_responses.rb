class AddDiscardedAtToResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :responses, :discarded_at, :datetime
    add_index :responses, :discarded_at
    add_column :participants, :discarded_at, :datetime
    add_index :participants, :discarded_at
  end
end
