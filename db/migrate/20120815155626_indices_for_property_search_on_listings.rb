class IndicesForPropertySearchOnListings < ActiveRecord::Migration
  def change
    add_index :listings, :ListingDate
  end
end
