class ChangePhoneFormatInHouses < ActiveRecord::Migration
  def up
    change_column :houses, :phone, :string
  end

  def down
    change_column :houses, :phone, :integer
  end
end
