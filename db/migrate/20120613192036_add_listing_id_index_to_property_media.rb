class AddListingIdIndexToPropertyMedia < ActiveRecord::Migration
  def change
    add_index :property_media, :ListingID
  end
end
