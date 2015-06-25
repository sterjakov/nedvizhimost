# -*- encoding : utf-8 -*-
class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :title
      t.string :title_postfix
      t.string :email
      t.string :meta_description
      t.string :meta_keywords
      t.integer :similar_posts_count
      t.text :footer_description

      t.timestamps
    end
  end
end
