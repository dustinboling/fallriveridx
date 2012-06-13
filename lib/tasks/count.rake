namespace :count do

  desc "Count all the properties"
  task :listings => :environment do
    puts "Counting listings..."
    count = Listing.count
    puts "Total listings: #{count}"
  end

end
