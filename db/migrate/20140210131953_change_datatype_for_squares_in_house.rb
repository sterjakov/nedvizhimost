class ChangeDatatypeForSquaresInHouse < ActiveRecord::Migration
  def up
    change_table :houses do |t|
      t.change :square_main,    :float
      t.change :square_live,    :float
      t.change :square_kitchen, :float
    end
  end

  def down
    change_table :houses do |t|
      t.change :square_main,    :integer
      t.change :square_live,    :integer
      t.change :square_kitchen, :integer
    end
  end
end
