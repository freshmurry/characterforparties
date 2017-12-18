class AddInstantToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :instant, :integer, default: 1
  end
end