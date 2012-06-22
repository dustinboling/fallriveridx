class DropAllIndexesForRealThisTime < ActiveRecord::Migration
  def up
    remove_index :listings, :ListingID
    remove_index :listings, :ListingKey
    remove_index :listings, :FullStreetAddress
    remove_index :listings, :City
    remove_index :listings, :Latitude
    remove_index :listings, :Longitude
  end

  def down
  end
end
