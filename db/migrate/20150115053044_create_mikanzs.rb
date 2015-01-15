class CreateMikanzs < ActiveRecord::Migration
  def change
    create_table :mikanzs do |t|
      t.integer :owner_id
      t.string :name,         null: false
      t.datetime :start_time, null: false
      t.text :content,        null: false

      t.timestamps
    end

    add_index :mikanzs, :owner_id
  end
end
