namespace :destroy do 

  desc "destroy listings"
  task :listings => :environment do 
    Listing.find_each(&:destroy)
  end
end
