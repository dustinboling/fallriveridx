class ChangeListingDateToTextOnListings < ActiveRecord::Migration
  def up
    change_column :listings, :ListingDate, :text
  end

  def down
  end
end
