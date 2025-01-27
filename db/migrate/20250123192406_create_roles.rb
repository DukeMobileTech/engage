class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    create_table :user_roles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :role, null: false, foreign_key: true

      t.timestamps
    end
    create_table :user_sites do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :site, null: false, foreign_key: true

      t.timestamps
    end
    add_column :responses, :user_id, :integer, null: true
    add_index :responses, :user_id
  end
end
