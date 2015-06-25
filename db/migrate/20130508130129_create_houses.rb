# -*- encoding : utf-8 -*-
class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.integer :realty_type
      t.integer :apartment_type
      t.integer :apartment_age
      t.string :address
      t.integer :metro_id
      t.integer :metro_time
      t.integer :house_type
      t.integer :floor_house
      t.integer :floor_apartments
      t.integer :square_main
      t.integer :square_live
      t.integer :square_kitchen
      t.integer :balcon
      t.integer :loggia
      t.integer :room_type
      t.integer :windows
      t.integer :apartment_status
      t.integer :bathroom
      t.text :description
      t.integer :sell_type
      t.integer :price
      t.integer :credit
      t.integer :residential_type
      t.boolean :deposit
      t.integer :period
      t.integer :comission
      t.integer :furniture_status
      t.boolean :furniture_floor
      t.boolean :furniture_kitchen
      t.boolean :refrigerator
      t.boolean :tv
      t.boolean :animal
      t.boolean :children
      t.boolean :washing_mashine
      t.string :fio
      t.integer :phone
      t.string :email
      t.integer :status
      t.string :thumb

      t.timestamps
    end
  end
end
