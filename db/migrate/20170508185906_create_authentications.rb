class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.integer :client_id
      t.string :os
      t.string :device_id
      t.string :language
      t.string :reg_id
      t.text :access_token

      t.timestamps
    end
  end
end
