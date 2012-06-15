class AddIdxShortcodeSearchIndexToListings < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE INDEX idx_shortcode_search 
        ON listings ("City", "ListPrice", "BedroomsTotal", "BathsTotal", "BuildingSize", "ListingStatus")
      SQL
  end
end
