class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :name
      t.integer :position
      t.text :description

      t.timestamps
    end
  end
end
