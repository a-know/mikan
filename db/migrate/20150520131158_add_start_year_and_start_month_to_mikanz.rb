class AddStartYearAndStartMonthToMikanz < ActiveRecord::Migration
  def change
    add_column :mikanzs, :start_year, :integer
    add_column :mikanzs, :start_month, :integer
  end
end
