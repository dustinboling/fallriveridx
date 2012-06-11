namespace :destroy do 

  desc "destroy listings"
  task :listings => :environment do 
    count = Listing.count
    puts "Total number of listings: #{count}"
    destroy_count = 0
    Listing.where.('id > 0').find_each do |listing|
      listing.delete
      destroy_count = destroy_count + 1
    end
    puts "Total listings destroyed: #{destroy_count}"
  end
end
