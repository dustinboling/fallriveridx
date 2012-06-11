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
    fields = Listing.columns

    # enter year
    @current_year = 1980
    while @current_year < 2013
      # count the records, for the given year
      print "getting the total number of records for #{@current_year}..."
      get_count

      # jump to next year if no records for the given year
      until !@count.nil?
        @current_year = @current_year + 1
        print "no records. checking #{@current_year}..."
        get_count
      end
      puts "total number of records: #{@count}"

      # write to database, split into batches if necessary
      @counter = 0
      print "Committing properties for #{@current_year}:\n "
      split_records
      split_records_count = @offset.count
      batch_count = 1
      @offset.each do |key, offset|
        print "\nBatch #{batch_count} of #{split_records_count}"
        begin
          @client.search(:search_type => :Property, :class => :RES, :query => "(ListingDate=#{@current_year}-01-01-#{@current_year}-12-31)", :limit => 10000, :offset => offset, :read_timeout => 100) do |data|
            begin
              print "\r#{@counter}/#{@count}"
              @listing = Listing.new

              fields.each do |field|
                stripped_field = field.gsub(/'/, "")
                @listing["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
              end
              @listing.save
              @counter = @counter + 1
            rescue Timeout::Error => e
              puts "This happened: #{e}, retrying..."
              redo
            end
          end
          batch_count = batch_count + 1
        rescue Timeout::Error => e
          puts "Operation timed out, attempting retry..."
          redo
        end
      end
      puts "Successfully added #{@counter} records to the database from #{@current_year}."
      @current_year = @current_year + 1
    end
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
    @client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentStatus=|A)", :limit => 1000000) do |data|
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

    puts "figuring out which month and year to write..."
    last_line = `tail -n 1 #{Dir.pwd}/last_yearmonth.csv`
    last_line_ary = last_line.gsub(/\n/, '').gsub(/ /, '').split(',')
    last_year = last_line_ary[0].to_i
    last_month = last_line_ary[1].to_i

    # increment year/month
    if last_month == 12
      @current_year = (last_year + 1).to_s
      @current_month = to_padded_month(1)
    else
      @current_year = last_year.to_s
      @current_month = to_padded_month(last_month + 1)
    end

    # set days in month
    calculate_last_day_in_month
    puts "last day in month is: #{@last_day_in_month}"

    # count prop_media since for current month and year
    puts "Counting records for #{@current_year}-#{@current_month}..."
    begin
      query = "(PropMediaCreatedTimestamp="
      query = query + "#{@current_year}-#{@current_month}-01T00:00:00-"
      query = query + "#{@current_year}-#{@current_month}-#{@last_day_in_month}T23:59:59),"
      query = query + "(PropertyType=|Residential)"
      options =  {:search_type => :Media, :class => :PROP_MEDIA, :query => query, :count_mode => :both, :limit => 1}

      @client.search(options) do |data|
        @count = @client.rets_data[:count].to_i
      end
    rescue Timeout::Error
      puts "Retrying..."
      retry
    end
    puts "count is: #{@count}..."

    if @count > 500000
      number_of_batches = (@count / 500000).ceil
      @days = (1..@last_day_in_month.to_i).to_a

      check_every_day_for_limit

      i = 1
      @days.each do |day|
        puts "Doing batch ##{i} for #{@current_year}-#{@current_month}..."
        begin
          query = "(PropMediaCreatedTimestamp="
          query = query + "#{@current_year}-#{@current_month}-#{to_padded_month(i)}T00:00:00-"
          query = query + "#{@current_year}-#{@current_month}-#{to_padded_month(i)}T23:59:59),"
          query = query + "(PropertyType=|Residential)"
          options =  {:search_type => :Media, :class => :PROP_MEDIA, :query => query, :count_mode => :both, :limit => 1}

          @client.search(options) do |data|
            @count = @client.rets_data[:count].to_i
          end

          if @count > 500000
            abort("Too many in this split")
          end
        rescue Timeout::Error
          puts "Retrying..."
          retry
        end

        # add to database
        split_records
        split_records_count = @offset.count
        batch_count = 1

        puts "total number of records: #{@count}"
        puts "Adding property media for #{@current_year}-#{@current_month}-#{i}..."
        @counter = 0
        @offset.each do |key, offset|
          print "\nBatch #{batch_count} of #{split_records_count}\n"
          begin
            query = "(PropMediaCreatedTimestamp="
            query = query + "#{@current_year}-#{@current_month}-#{to_padded_month(i)}T00:00:00-"
            query = query + "#{@current_year}-#{@current_month}-#{to_padded_month(i)}T23:59:59),"
            query = query + "(PropertyType=|Residential)"
            options = {:search_type => :Media, :class => :PROP_MEDIA, :query => query, :offset => offset, :limit => 10000 }

            @client.search(options) do |data|
              print "\r#{@counter}/#{@count}"
              @property_media = PropertyMedia.new

              fields.each do |field|
                stripped_field = field.gsub(/'/, "")
                @property_media["#{stripped_field}"] = data["#{stripped_field}"]
              end
              @property_media.save
              @counter = @counter + 1
            end
            batch_count = batch_count + 1
          rescue Timeout::Error
            puts "Rescuing from timeout..."
            redo
          end
        end
        puts "\nWriting to log..."
        log_success("property_media_seed_log.txt", true, true)
        i = i + 1
      end
      # store unix timestamp
      f = File.open("#{Dir.pwd}/log/last_property_media_update.txt", 'a')
      f.write("#{DateTime.now.to_time.to_i}\n")
      f.close

      # store last position (year, month)
      f = File.open("#{Dir.pwd}/last_yearmonth.csv", 'a')
      f.write("#{@current_year}, #{@current_month}\n")
      f.close
    else
      # add to database
      split_records
      split_records_count = @offset.count
      batch_count = 1

      puts "total number of records: #{@count}"
      puts "Adding property media for #{@current_year}-#{@current_month}..."
      @counter = 0
      @offset.each do |key, offset|
        print "\nBatch #{batch_count} of #{split_records_count}\n"
        begin
          query = "(PropMediaCreatedTimestamp="
          query = query + "#{@current_year}-#{@current_month}-01T00:00:00-"
          query = query + "#{@current_year}-#{@current_month}-#{@last_day_in_month}T23:59:59),"
          query = query + "(PropertyType=|Residential)"
          options = {:search_type => :Media, :class => :PROP_MEDIA, :query => query, :offset => offset, :limit => 10000 }

          @client.search(options) do |data|
            print "\r#{@counter}/#{@count}"
            @property_media = PropertyMedia.new

            fields.each do |field|
              stripped_field = field.gsub(/'/, "")
              @property_media["#{stripped_field}"] = data["#{stripped_field}"]
            end
            @property_media.save
            @counter = @counter + 1
          end
          batch_count = batch_count + 1
        rescue Timeout::Error
          puts "Rescuing from timeout..."
          redo
        end
      end
    end

    # write success to log
    puts "Writing to log..."
    log_success("property_media_seed_log.txt", true, true)

    # store unix timestamp
    f = File.open("#{Dir.pwd}/log/last_property_media_update.txt", 'a')
    f.write("#{DateTime.now.to_time.to_i}\n")
    f.close

    # store last position (year, month)
    f = File.open("#{Dir.pwd}/last_yearmonth.csv", 'a')
    f.write("#{@current_year}, #{@current_month}\n")
    f.close

    # all done, note that the last record is a rets_data so we subtract it from the count.
    puts "Successfully added #{@counter - 1} records to the database from #{@current_year}-#{@current_month}."
  end

  ###
  # procedures
  def get_count
    @client.search(:search_type => :Property, :class => :RES, :query => "(ListingDate=#{@current_year}-01-01-#{@current_year}-12-31)", :count_mode => :both, :limit => 200) do |data|
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

  def split_records
    if !@count 
      abort("Count failed!")
    end

    split_count = (@count.to_f / 10000.0).ceil
    @offset = {}

    offset_count = 0
    split_count.times do |i|
      i = i + 1 
      if i == 1
        @offset["offset#{i}"] = i
      else
        @offset["offset#{i}"] = offset_count
      end
      offset_count = offset_count + 10000
    end
  end

  def log_success(file, year, month)
    if year == true && month == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y - %I:%M:%S")}, #{@current_year}, #{@current_month}, #{@count}, #{@counter}\n")
      f.close
    elsif year == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y - %I:%M:%S")}, #{@current_year}, #{@count}, #{@counter}\n")
      f.close
    else
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y - %I:%M:%S")}, #{@count}\n")
      f.close
    end
  end

  def to_padded_month(month)
    if month <= 9
      return  '0' + month.to_s
    else
      return month.to_s 
    end
  end

  def calculate_last_day_in_month
    months_with_31_days = ["01", "03", "05", "07", "08", "10", "12"]
    months_with_30_days = ["04", "06", "09", "11"]

    if months_with_31_days.include?(@current_month)
      @last_day_in_month = "31"
    elsif months_with_30_days.include?(@current_month)
      @last_day_in_month = "30"
    elsif @current_month == "02" && @current_year == 2012
      @last_day_in_month = "29"
    elsif @current_month == "02"
      @last_day_in_month = "28"
    else
      abort("Could not resolve number of days for current month.")
    end
  end

  def check_every_day_for_limit
    puts "Checking for days > 500000"
    @days.each do |day|
      begin
        query = "(PropMediaCreatedTimestamp="
        query = query + "#{@current_year}-#{@current_month}-#{to_padded_month(day)}T00:00:00-"
        query = query + "#{@current_year}-#{@current_month}-#{to_padded_month(day)}T23:59:59),"
        query = query + "(PropertyType=|Residential)"
        options =  {:search_type => :Media, :class => :PROP_MEDIA, :query => query, :count_mode => :both, :limit => 1}

        @client.search(options) do |data|
          @count = @client.rets_data[:count].to_i
        end

        # count the records for each day
        @count_ary = []
        if @count > 500000
          puts "There are #{@count} records for #{day}!"
          @count_ary.push([@count, day])
        else
          puts "There are #{@count} records for #{day}"
        end

        # abort with details if any days exceed 500000
        if !@count_ary.empty?
          abort("The following days had counts of > 500000: #{@count_ary}")
        end
      rescue Timeout::Error
        puts "Retrying..."
        retry
      end
    end
  end
end
