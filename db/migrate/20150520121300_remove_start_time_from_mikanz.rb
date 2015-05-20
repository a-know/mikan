class RemoveStartTimeFromMikanz < ActiveRecord::Migration
  def change
    remove_column :mikanzs, :start_time, :datetime
  end
end
