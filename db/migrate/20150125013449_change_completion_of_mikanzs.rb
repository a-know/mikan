class ChangeCompletionOfMikanzs < ActiveRecord::Migration
  def self.up
    change_column :mikanzs, :completion, 'integer USING CAST(completion AS integer)'
  end

  def self.down
    change_column :mikanzs, :completion, 'string USING CAST(completion AS string)'
  end
end
