class AddIndexToWatering < ActiveRecord::Migration
  def change
    change_column_null :waterings, :mikanz_id, true
    add_index :waterings, [:user_id, :mikanz_id], unique:true
    add_index :waterings, [:mikanz_id, :user_id], unique:true
  end
end
