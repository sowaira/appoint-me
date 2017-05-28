class AddBusinessIdToDesigners < ActiveRecord::Migration[5.0]
  def change
    add_column :designers, :business_id, :integer
  end
end
