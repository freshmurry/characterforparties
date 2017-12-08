class AddInstantToBarbershops < ActiveRecord::Migration[5.1]
  def change
    add_column :barbershops, :instant, :integer, default: 1
    add_column :barbershops, :service, :string
  end
end
