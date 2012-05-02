require 'csv'

csv = "#{Dir.pwd}/rets-metadata-media-prop_media.csv"

file = "#{Dir.pwd}/prop_media_fields.txt"

CSV.foreach(csv) do |row|
  f = File.open(file, 'a')
  f.write("\'#{row[0]}\',")
  f.close
end
