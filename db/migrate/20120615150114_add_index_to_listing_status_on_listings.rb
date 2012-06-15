class AddIndexToListingStatusOnListings < ActiveRecord::Migration
  def change
    add_index :listings, :ListingStatus
  end
end
