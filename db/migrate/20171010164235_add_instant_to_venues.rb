class AddInstantToBarbershops < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :instant, :integer, default: 1
    add_column :venues, :service, :string
  end
end
