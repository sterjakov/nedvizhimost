class ChangePriceFormatInHouses < ActiveRecord::Migration
  def up
    change_column :houses, :price, :string
  end

  def down
    change_column :houses, :price, :integer
  end
end
