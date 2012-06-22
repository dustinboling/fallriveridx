class DropAllIndexesForCasting < ActiveRecord::Migration
  def up
    remove_index :listings, :BathsTotal
    remove_index :listings, :BedroomsTotal
    execute <<-SQL
      drop index idx_shortcode_search;
      drop index idx_query;
    SQL
  end

  def down
  end
end
