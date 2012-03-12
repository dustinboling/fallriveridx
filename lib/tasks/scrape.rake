namespace :scrape do
  
  require 'csv'
  
  desc "Get RETS data for the desired city"
  task :city => :environment do
    client = RETS::Client.login(:url => "")
    
    zip_csv = '/Users/alan/sites/fallriveridx/lib/assets/csv/zip_codes.csv'
    @zip_codes = []
    
    # Move the zip codes into a variable
    CSV.foreach(zip_csv) do |row|
      @zip_codes << row[1].split(';')
    end
    
    
    
  end
  
end