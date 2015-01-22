class AddDeletedAtToMikanzs < ActiveRecord::Migration
  def change
    add_column :mikanzs, :deleted_at, :datetime
    add_index :mikanzs, :deleted_at
  end
end
