require 'csv'

csv = "#{Dir.pwd}/rets-metadata-agent-agent.csv"

file = "#{Dir.pwd}/agent_fields_with_type.csv"

CSV.foreach(csv) do |row|
  f = File.open(file, 'a')
  f.write("\'#{row[0]}\',#{row[6]}\n")
  f.close
end
