namespace :destroy do 

  desc "destroy listings"
  task :listings => :environment do 
    count = Listing.count
    puts "Total number of listings: #{count}"
    destroy_count = 0
    Listing.find_each do |listing|
      Listing.delete
      destroy_count = destroy_count + 1
    end
    puts "Total listings destroyed: #{destroy_count}"
  end
end
