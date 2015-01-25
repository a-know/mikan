class ChangeCompletionOfMikanzs < ActiveRecord::Migration
  def self.up
    change_column :mikanzs, :completion, :integer, :null => false
  end

  def self.down
    change_column :mikanzs, :completion, :string,  :null => true
  end
end
