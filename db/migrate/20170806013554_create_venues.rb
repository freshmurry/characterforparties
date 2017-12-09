class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :location_type #Public or Private
      t.string :venue_type #Church, Park District, Town Hall, Parking Lot, Back Yard, Vine Yard, Golf Course, Warehouse
      t.string :event_type
      t.integer :accommodate #10-50, 50-100, 100-150, 150-200, 200-250, 250-300, 300+
      t.integer :rest_room
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_kitchen
      t.boolean :is_tables
      t.boolean :is_chairs
      t.boolean :is_microphone
      t.boolean :is_projector
      t.boolean :is_bar
      t.boolean :is_self_parking
      t.boolean :is_valet_parking
      t.boolean :is_garage_parking
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_wifi
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end