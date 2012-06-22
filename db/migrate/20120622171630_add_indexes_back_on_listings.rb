class AddIndexesBackOnListings < ActiveRecord::Migration
  def up
    add_index :listings, :BathsTotal
    add_index :listings, :BedroomsTotal
    execute <<-SQL
      create index idx_query on listings ("ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "LotSizeSQFT", "Latitude", "Longitude");
      create index idx_shortcode_search on listings ("City", "ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "ListingStatus");
    SQL
  end

  def down
  end
end
