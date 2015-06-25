class AddMainHeadToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :main_head, :string
  end
end
