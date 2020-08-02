class CreatePools < ActiveRecord::Migration[5.0]
  def change
    create_table :pools do |t|
      t.string :location_type
      t.string :address
      t.string :pool_type
      t.string :listing_name
      t.text :summary
      t.boolean :is_garage_parking
      t.boolean :is_heated_pool
      t.boolean :is_parking
      t.boolean :is_chairs
      t.boolean :is_portable_speaker
      t.string :payment_type
      t.integer :price
      t.integer :tip
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end