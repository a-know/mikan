class AddUrlToMikanz < ActiveRecord::Migration
  def change
    add_column :mikanzs, :url, :string
  end
end
