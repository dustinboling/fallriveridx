namespace :destroy do 

  desc "destroy listings"
  task :listings => :environment do 
    count = Listing.count
    puts "Total number of listings: #{count}"
    destroy_count = 0
    Listing.where('id >= 0').find_each do |listing|
      listing.delete
      destroy_count = destroy_count + 1
    end
    puts "Total listings destroyed: #{destroy_count}"
  end

  desc "destroy listings from 2005"
  task :listings2005 => :environment do
    l = Listing.where('"ListingDate" like ?', '2005-%')
    count = l.count
    puts "There are #{count} listings from 2005"
    l.find_each(&:destroy)
    puts "Now there are none."
  end

  desc "destroy listings from 2008"
  task :listings2008 => :environment do
    l = Listing.where('"ListingDate" like ?', '2008-%')
    count = l.count
    puts "There are #{count} listings from 2008"
    l.find_each(&:destroy)
    puts "Now there are none."
  end

end
