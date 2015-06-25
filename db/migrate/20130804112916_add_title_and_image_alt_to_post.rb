# -*- encoding : utf-8 -*-
class AddTitleAndImageAltToPost < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :image_alt, :string
  end
end
