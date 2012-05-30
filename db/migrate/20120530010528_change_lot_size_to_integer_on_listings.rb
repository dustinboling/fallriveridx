class ChangeLotSizeToIntegerOnListings < ActiveRecord::Migration
  def up
    execute <<-SQL
      alter table listings add column new_lot_size numeric;
      update listings set new_lot_size = CAST("LotSizeSQFT" as numeric);
      alter table listings rename "LotSizeSQFT" to lot_size_string;
      alter table listings rename new_lot_size to "LotSizeSQFT";
      alter table listings drop lot_size_string;
    SQL
  end

  def down
  end
end
