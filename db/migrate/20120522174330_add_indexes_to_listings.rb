class AddIndexesToListings < ActiveRecord::Migration
  def change
    add_index :listings, :FullStreetAddress
  end
end
