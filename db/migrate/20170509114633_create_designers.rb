class CreateDesigners < ActiveRecord::Migration[5.0]
  def change
    create_table :designers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :password
      t.string :salt
      t.string :unconfirmed_email
      t.datetime :confirmed_at
      t.string :confirmation_token

      t.timestamps
    end
  end
end
