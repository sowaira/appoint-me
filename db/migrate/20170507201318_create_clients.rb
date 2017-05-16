class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :salt
      t.string :picture
      t.boolean :push_notification

      t.timestamps
    end
  end
end
