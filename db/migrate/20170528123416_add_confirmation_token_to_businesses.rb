class AddConfirmationTokenToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :confirmation_token, :string
  end
end
