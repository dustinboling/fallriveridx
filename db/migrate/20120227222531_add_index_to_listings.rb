class AddIndexToListings < ActiveRecord::Migration
  def change
    add_index :listings, :agent_id
  end
end
