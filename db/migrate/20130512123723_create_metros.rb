# -*- encoding : utf-8 -*-
class CreateMetros < ActiveRecord::Migration
  def up
    create_table :metros do |t|
      t.string :name
    end
  end
end
