class CreatePools < ActiveRecord::Migration[5.1]
  def change
    create_table :pools do |t|
      t.string :pool_type #Above Ground, In-Ground
      t.integer :accommodate #1, 2, 3, 4
      t.integer :restrooms
      t.string :listing_name
      t.text :description
      t.string :address
      t.boolean :is_chairs
      t.boolean :is_speaker
      t.boolean :is_parking
      t.boolean :is_garage_parking
      t.boolean :is_heated_pool
      t.boolean :is_accessible
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end