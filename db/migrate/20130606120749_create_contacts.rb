# -*- encoding : utf-8 -*-
class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :author
      t.string :email
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
