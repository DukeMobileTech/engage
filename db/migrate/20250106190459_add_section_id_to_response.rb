class AddSectionIdToResponse < ActiveRecord::Migration[8.0]
  def change
    add_reference :responses, :section, null: true, foreign_key: true
  end
end
