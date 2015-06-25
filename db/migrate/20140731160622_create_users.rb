class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :salt
      t.integer :role
      t.string :auth_token

      t.timestamps
    end
  end
end
