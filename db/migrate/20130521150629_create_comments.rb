# -*- encoding : utf-8 -*-
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.string :author
      t.string :email
      t.integer :post_id
      t.integer :status

      t.timestamps
    end
  end
end
