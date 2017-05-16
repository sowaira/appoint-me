class AddColumnsToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :unconfirmed_email, :string
    add_column :clients, :confirmed_at, :datetime
    add_column :clients, :confirmation_token, :string
  end
end
