class AddFieldsToBarbershops < ActiveRecord::Migration[5.0]
  def change
    add_column :barbershops, :latitude, :float
    add_column :barbershops, :longitude, :float
  end
end