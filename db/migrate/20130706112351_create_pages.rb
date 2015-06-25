# -*- encoding : utf-8 -*-
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :alt
      t.text :description
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end
end
