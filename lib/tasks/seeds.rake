namespace :seed do

  require 'csv'

  desc "Initial load of properties into the database"
  task :properties  => :environment do
    print "setting up client..."
    @client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )

    puts "ok!"

    puts "populating fields array..."
    csv = CSV.read("#{Dir.pwd}/property_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # enter year
    last_year = `tail -n 1 #{Dir.pwd}/last_year.txt`.to_i
    @current_year = last_year + 1

    # count the records, for the given year
    print "getting the total number of records for #{@current_year}..."
    get_count

    # jump to next year if no records for the given year
    until !@count.nil?
      @current_year = @current_year + 1
      print "no records. checking #{@current_year}..."
      get_count
    end

    # make sure we are not running up against the query ceiling
    # write fail to log, then quit
    if @count >= 1000000
      log_error("properties_seed_log.txt", "FAIL - Too many records")
      abort("Too many records (over 1m), find a new way to split.")
    end

    puts "done!"
    puts "total number of records: #{@count}"

    # write to database, split into two batches if necessary
    counter = 1
    if @count >= 500000
      print "Committing first half of properties for #{@current_year}:\n"
      records = @client.search(:search_type => :Property, :class => :RES, :query => "(ListingDate=#{@current_year}-01-01-#{@current_year}-06-31)", :offset => 1, :limit => 500000) do |data|
        print "\\\r#{count}/#{@count}"
        @listing = Listing.new

        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @listing["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
        end
        @listing.save
        counter = counter + 1
      end

      print "\n\nCommitting second half of properties for #{@current_year}:\n"
      records = @client.search(:search_type => :Property, :class => :RES, :query => "(ListingDate=#{@current_year}-07-01-#{@current_year}-12-31)", :offset => 500000, :limit => 500000) do |data|
        print "\\\r#{count}/#{@count}"
        @listing = Listing.new

        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @listing["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
        end
        @listing.save
        counter = counter + 1
      end

    else
      print "Committing properties for #{@current_year}:\n "
      begin
        records = @client.search(:search_type => :Property, :class => :RES, :query => "(ListingDate=#{@current_year}-01-01-#{@current_year}-12-31)", :limit => 500000) do |data|
          print "\\\r#{counter}/#{@count}"
          @listing = Listing.new

          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @listing["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
          end
          @listing.save
          counter = counter + 1
        end
      rescue APIError, ResponseError, HTTPError => e
        puts "This happened: #{e}."
      end
    end
    puts "\nAll done."

    # write current year to placeholder file
    puts "Incrementing year..."
    f = File.open("#{Dir.pwd}/last_year.txt", 'a')
    f.write("#{@current_year}\n")
    f.close 

    # write success to log
    puts "Writing to log..."
    log_success("properties_seed_log.txt", true)

    # store unix timestamp
    f = File.open("#{Dir.pwd}/log/last_property_update.txt", 'a')
    f.write("#{DateTime.now.to_time.to_i}\n")
    f.close

    # all done
    puts "Successfully added #{counter} records to the database from #{@current_year}."
  end

  desc "Initial agents seed"
  task :agents => :environment do
    print "setting up client..."
    @client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )

    puts "ok!"

    puts "populating fields array..."
    csv = CSV.read("#{Dir.pwd}/agent_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # get a count of active agents
    @client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentStatus=|A)", :count_mode => :both, :limit => 1) do |data|
      @count = @client.rets_data[:count].to_i
    end
    puts "There are currently #{@count} active agents in CARETS."

    # write agents to the database
    print "Committing agents to the database: "
    @client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentStatus=|A)", :limit => 500000) do |data|
      print "."

      @agent = Agent.new
      fields.each do |field|
        stripped_field = field.gsub(/'/, "")
        @agent["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
      end
      @agent.save
    end

    # write success to log
    puts "Writing to log"
    log_success("agents_seed_log.txt", false)

    puts "Writing to last_agent_update.txt"
    # store unix timestamp
    # to get back to the DateTime: DateTime.strptime(unix_timestamp.to_s, '%s')
    f = File.open("#{Dir.pwd}/log/last_agent_update.txt", 'a')
    f.write("#{DateTime.now.to_time.to_i}\n")
    f.close

    # all done
    puts "Successfully added #{@count} agents to the database"
  end

  desc "Initial brokers seed"
  task :brokers => :environment do
    print "setting up client..."
    @client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )

    puts "ok!"

    puts "populating fields array..."
    csv = CSV.read("#{Dir.pwd}/agent_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # get a count of active brokers
    @client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentStatus=|A),(AgentRole=|Broker)", :count_mode => :both, :limit => 1) do |data|
      @count = @client.rets_data[:count].to_i
    end
    puts "There are currently #{@count} active brokers in CARETS."

    # write brokers to the database
    print "Committing brokers to the database: "
    @client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentStatus=|A),(AgentRole=|Broker)", :limit => 500000) do |data|
      print "#{data['AgentID']}/"

      @broker = Broker.new
      fields.each do |field|
        stripped_field = field.gsub(/'/, "")
        @broker["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
      end
      @broker.save
    end

    # write success to log
    puts "\nWriting to log..."
    log_success("brokers_seed_log.txt", false)

    # all done
    puts "Successfully added #{@count} brokers to the database."
  end

  desc "Initial property media seed"
  task :media => :environment do
    print "setting up client..."
    @client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )
    puts "ok!"

    puts "populating fields array..."
    csv = CSV.read("#{Dir.pwd}/prop_media_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # count prop_media since 2004

    # split into groups of 500,000 or less
    if @count > 500000
      puts "splitting up count"
      splits = (@count / 500000.0).ceil
      puts "splitting up into #{splits} groups"

      # set counters, container
      n = 1
      low = 1
      high = 500000
      split_ranges = {}

      # set ranges
      splits.times do |i|
        # fix 0 offset of the times function
        i = i + 1

        # set values to hash
        split_ranges["range#{n}"] = [low, high]

        # increment counters
        low = low + 500000
        high = high + 500000
        n = n + 1
      end
    else
      puts "no need to split up count, moving on..."
    end

    # add them to the database
    split_ranges.each do |key, value|
      offset = value[0]

      # query 
      @client.search(:search_type => :Media, :class => :PROP_MEDIA, :query => "()", :offset => offset, :limit => 500000) do |data|
        @listing_media = ListingMedia.new

        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @listingmedia["#{stripped_field}"] = data["#{stripped_field}"]
        end
        @listing_media.save
      end
    end
  end

  ###
  # procedures
  def get_count
    @client.search(:search_type => :Property, :class => :RES, :query => "(ListingDate=#{@current_year}-01-01-#{@current_year}-12-31)", :count_mode => :both, :limit => 1) do |data|
      @count = @client.rets_data[:count].to_i
    end
  end

  ###
  # logging
  def log_error(file, error_msg)
    f = File.open("#{Dir.pwd}/log/#{file}", 'a')
    f.write("#{Time.now.strftime("%m-%d-%Y - %I:%M:%S")}, #{@current_year}, #{error_msg}\n")
    f.close
  end

  def log_success(file, year)
    if year == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y - %I:%M:%S")}, #{@current_year}, #{@count}, #{counter}\n")
      f.close
    else
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y - %I:%M:%S")}, #{@count}\n")
      f.close
    end
  end
end
