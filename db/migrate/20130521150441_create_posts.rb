# -*- encoding : utf-8 -*-
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :name
      t.string  :alt
      t.text    :description
      t.string  :meta_key
      t.string  :meta_description
      t.integer :category_id
      t.string  :image

      t.timestamps
    end
  end
end
