class CreateUserSittings < ActiveRecord::Migration[8.0]
  def change
    create_table :user_sittings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :sitting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
