class AddInstantToPools < ActiveRecord::Migration[5.1]
  def change
    add_column :pools, :instant, :integer, default: 1
  end
end