# encoding: utf-8
class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.integer :post_id

      t.timestamps
    end
  end
end
