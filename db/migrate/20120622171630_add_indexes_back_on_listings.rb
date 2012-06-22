class AddIndexesBackOnListings < ActiveRecord::Migration
  def up
    add_index :listings, :BathsTotal
    add_index :listings, :BedroomsTotal
    add_index :listings, :ListingID
    add_index :listings, :ListingKey
    add_index :listings, :FullStreetAddress
    add_index :listings, :City
    add_index :listings, :Latitude
    add_index :listings, :Longitude
    execute <<-SQL
      create index idx_query on listings ("ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "LotSizeSQFT", "Latitude", "Longitude");
      create index idx_shortcode_search on listings ("City", "ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "ListingStatus");
    SQL
  end

  def down
  end
end
