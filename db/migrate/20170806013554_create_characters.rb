class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :character_type
      t.string :address
      t.string :listing_name
      t.text :description
      t.string :time_limit
      t.integer :price
      t.boolean :active
      t.float :latitude
      t.float :longitude
      t.integer :instant, deafault: 1
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end