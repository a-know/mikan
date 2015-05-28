class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, null: false
      t.references :watering, index: true
      t.integer :kind, null: false
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :waterings
  end
end
