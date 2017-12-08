class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, default: 1 
      t.references :barbershop, foreign_key: true
      t.references :reservation, foreign_key: true
      t.references :barber, foreign_key: true
      t.references :client, foreign_key: true
      t.string :type
  
      t.timestamps
    end
  end
end