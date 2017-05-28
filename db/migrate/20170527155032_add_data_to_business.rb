class AddDataToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :email, :string
    add_column :businesses, :encripted_password, :string
    add_column :businesses, :salt, :string
    add_column :businesses, :unconfirmed_email, :string
    add_column :businesses, :confirmed_at, :datetime
  end
end
