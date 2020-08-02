class AddInstantToPools < ActiveRecord::Migration[5.0]
  def change
    add_column :pools, :instant, :integer, default: 1
    add_column :pools, :service, :string
  end
end