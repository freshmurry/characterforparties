class CreateBarbershops < ActiveRecord::Migration[5.0]
  def change
    create_table :barbershops do |t|
      t.string :location_type
      t.string :address
      t.string :stylist_type
      t.string :style_type
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