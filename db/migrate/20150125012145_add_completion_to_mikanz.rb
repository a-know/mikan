class AddCompletionToMikanz < ActiveRecord::Migration
  def change
    add_column :mikanzs, :completion, :string
  end
end
