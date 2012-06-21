class ChangeBedroomsTotalAndBathsTotalOnListingsToInteger < ActiveRecord::Migration
  def change
    puts "Finding any empty spaces on column BedroomsTotal and setting to zero..."
    i = 0
    li = Listing.where(:BedroomsTotal => "")
    li.each do |l|
      l.BedroomsTotal = 0
      l.save
      i = i + 1
    end
    puts "Total rows updated: #{i}"
    execute <<-SQL
      alter table listings add column bedrooms_total_int numeric;
      update listings set bedrooms_total_int = CAST("BedroomsTotal" as numeric);
      alter table listings rename "BedroomsTotal" to bedrooms_total_string;
      alter table listings rename bedrooms_total_int to "BedroomsTotal";
    SQL
    puts "BedroomsTotal completed."
    
    puts "Finding any empty spaces on column BathsTotal and setting to zero..."
    li = Listing.where(:BathsTotal => "")
    li.each do |l|
      l.BathsTotal = 0
      l.save
      i = i + 1
    end
    puts "Total rows updated: #{i}"
    execute <<-SQL
      alter table listings add column baths_total_int numeric;
      update listings set baths_total_int = CAST("BathsTotal" as numeric);
      alter table listings rename "BathsTotal" to baths_total_string;
      alter table listings rename baths_total_int to "BathsTotal";
    SQL
    puts "BathsTotal completed."
    puts "all done, goodbye."
  end
end
