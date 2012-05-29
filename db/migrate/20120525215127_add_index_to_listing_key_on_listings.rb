class AddIndexToListingKeyOnListings < ActiveRecord::Migration
  def change
    add_index :listings, :ListingKey
  end
end
