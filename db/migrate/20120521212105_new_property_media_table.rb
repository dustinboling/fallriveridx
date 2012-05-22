class NewPropertyMediaTable < ActiveRecord::Migration
  require 'csv'
  
  def up
    csv = "#{Dir.pwd}/prop_media_fields_with_type.txt"
    create_table :property_media do |t|
      CSV.foreach(csv) do |row|
        case row[1]
        when /Character/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /Boolean/
          t.boolean :"#{row[0].gsub(/'/, "")}"
        when /Decimal/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /Date/
          t.date :"#{row[0].gsub(/'/, "")}"
        when /DateTime/
          t.datetime :"#{row[0].gsub(/'/, "")}"
        when /Small/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /Long/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /Small/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /Tiny/
          t.integer :"#{row[0].gsub(/'/, "")}"
        when /Int/
          t.integer :"#{row[0].gsub(/'/, "")}"
        else
          t.text :"#{row[0].gsub(/'/, "")}"
        end
      end
    end
  end

  def down
  end
end
