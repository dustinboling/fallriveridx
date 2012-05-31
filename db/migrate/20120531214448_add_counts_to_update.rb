class AddCountsToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :new_count, :integer
    add_column :updates, :update_count, :integer
    add_column :updates, :error_count, :integer
  end
end
