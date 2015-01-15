class CreateMikanzs < ActiveRecord::Migration
  def change
    create_table :mikanzs do |t|
      t.integer :owner_id
      t.string :name
      t.datetime :start_time
      t.text :content

      t.timestamps null: false
    end
  end
end
