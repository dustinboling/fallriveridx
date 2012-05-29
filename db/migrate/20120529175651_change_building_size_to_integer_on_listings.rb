class ChangeBuildingSizeToIntegerOnListings < ActiveRecord::Migration
  def up
    execute <<-SQL
      alter table listings add column new_building_size numeric;
      update listings set new_building_size = CAST("BuildingSize" as numeric);
      alter table listings rename "BuildingSize" to building_size_string;
      alter table listings rename new_building_size to "BuildingSize";
      alter table listings drop new_building_size;
    SQL
  end

  def down
  end
end
