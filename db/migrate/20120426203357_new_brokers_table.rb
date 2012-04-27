class NewBrokersTable < ActiveRecord::Migration
  require 'csv'

  def up
    drop_table :brokers
    csv = "#{Dir.pwd}/agent_fields_with_type.csv"
    create_table :brokers do |t|
      CSV.foreach(csv) do |row|
        case row[1]
        when /Character/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /Long/
          t.text :"#{row[0].gsub(/'/, "")}"
        when /DateTime/
          t.datetime :"#{row[0].gsub(/'/, "")}"
        when /Date/
          t.date :"#{row[0].gsub(/'/, "")}"
        when /Boolean/
          t.boolean :"#{row[0].gsub(/'/, "")}"
        else
          t.text :"#{row[0].gsub(/'/, "")}"
        end
      end
    end
  end

  def down
  end
end
