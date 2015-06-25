# -*- encoding : utf-8 -*-
class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :author
      t.string :phone
      t.string :email
      t.text :description
      t.integer :status
      t.integer :house_id

      t.timestamps
    end
  end
end
