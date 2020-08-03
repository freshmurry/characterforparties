class CreatePools < ActiveRecord::Migration[5.0]
  def change
    create_table :pools do |t|
      t.string :pool_type
      t.string :location_type
      t.string :address
      t.string :listing_name
      t.text :description
      t.integer :accommodate
      t.integer :restrooms
      t.boolean :is_towels
      t.boolean :is_garage_parking
      t.boolean :is_heated_pool
      t.boolean :is_parking
      t.boolean :is_chairs
      t.boolean :is_speaker
      t.boolean :is_accessible
      t.integer :price
      t.integer :tip
      t.boolean :active
      t.float :latitude
      t.float :longitude
      t.integer :instant, deafault: 1
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end