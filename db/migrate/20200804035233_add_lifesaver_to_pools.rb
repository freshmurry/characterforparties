class AddLifesaverToPools < ActiveRecord::Migration[5.0]
  def change
    add_column :pools, :lifesaver, :string
  end
end
