class AddPictureToDesigners < ActiveRecord::Migration[5.0]
  def change
    add_column :designers, :picture, :string
  end
end
