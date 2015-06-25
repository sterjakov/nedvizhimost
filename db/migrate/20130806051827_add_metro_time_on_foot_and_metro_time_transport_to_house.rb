# -*- encoding : utf-8 -*-
class AddMetroTimeOnFootAndMetroTimeTransportToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :metro_time_on_foot, :integer
    add_column :houses, :metro_time_transport, :integer
  end
end
