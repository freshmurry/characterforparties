class CreatePools < ActiveRecord::Migration[5.0]
  def change
    create_table :pools do |t|
      t.string :location_type
      t.string :address
      t.string :pool_type
      t.string :listing_name
      t.text :summary
      t.boolean :is_accept_card
      t.boolean :is_accept_cash
      t.string :payment_type
      t.string :additional_service
      t.integer :price
      t.integer :tip
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end