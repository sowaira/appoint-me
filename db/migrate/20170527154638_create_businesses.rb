class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :address
      t.string :longitude
      t.string :latitude
      t.string :picture

      t.timestamps
    end
  end
end
