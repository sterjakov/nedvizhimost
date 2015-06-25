# -*- encoding : utf-8 -*-
class RemoveMetroTimeFromHouse < ActiveRecord::Migration
  def up
    remove_column :houses, :metro_time
  end

  def down
    add_column :houses, :metro_time, :integer
  end
end
