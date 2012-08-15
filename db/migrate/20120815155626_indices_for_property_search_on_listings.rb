class IndicesForPropertySearchOnListings < ActiveRecord::Migration
  def change
    add_index :listings, :ListingDate
    add_index :listings, [:ListingStatus, :City, :ListPrice, :ListingDate]
    add_index :listings, [:ListingStatus, :City, :ListPrice, :BedroomsTotal, :ListingDate]
    add_index :listings, [:ListingStatus, :City, :ListPrice, :BathsTotal, :ListingDate]
  end
end
