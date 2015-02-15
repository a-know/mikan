class AddMikanzImageToMikanz < ActiveRecord::Migration
  def change
    add_column :mikanzs, :mikanz_image, :string
  end
end
