class AddMetaToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :title, :string
    add_column :categories, :meta_key, :string
    add_column :categories, :meta_description, :string
  end
end
