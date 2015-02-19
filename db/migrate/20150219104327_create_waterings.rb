class CreateWaterings < ActiveRecord::Migration
  def change
    create_table :waterings do |t|
      t.references :user, index: true
      t.references :mikanz, index: true

      t.timestamps null: false
    end
    add_foreign_key :waterings, :users
    add_foreign_key :waterings, :mikanzs
  end
end
