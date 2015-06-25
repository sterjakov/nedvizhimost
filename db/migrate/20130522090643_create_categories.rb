# -*- encoding : utf-8 -*-
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :alt
      t.integer :parent_id

      t.timestamps
    end
  end
end
