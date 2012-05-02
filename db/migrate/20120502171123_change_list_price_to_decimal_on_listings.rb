class ChangeListPriceToDecimalOnListings < ActiveRecord::Migration
  def up
    change_column :listings, :ListPrice, :decimal, :precision => 14, :scale => 2
  end

  def down
  end
end
