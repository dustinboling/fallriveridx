class RemainingSingleIndexesForListings < ActiveRecord::Migration
  def up
    add_index :listings, :City
    add_index :listings, :ZipCode
    add_index :listings, :ListAgentAgentID
    add_index :listings, :SaleAgentAgentID
    add_index :listings, :ListPrice
    add_index :listings, :BedroomsTotal
    add_index :listings, :BathsTotal
    add_index :listings, :LotSizeSQFT
    add_index :listings, :ListingID
    add_index :listings, :Latitude
    add_index :listings, :Longitude
  end
end
