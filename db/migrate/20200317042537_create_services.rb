class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2, default: 0
      t.integer :instant, default: 1
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
