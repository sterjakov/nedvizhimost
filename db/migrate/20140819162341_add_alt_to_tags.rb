class AddAltToTags < ActiveRecord::Migration
  def change
    add_column :tags, :alt, :string
  end
end
