# -*- encoding : utf-8 -*-
class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :author
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
