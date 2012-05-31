namespace :update do

  desc "update properties"
  task :properties => :environment do
    client_login
    get_last_update_time("last_property_update.txt")

    # count since last update
    $client.search(:search_type => :Property, :class => :RES, :query => "(ModificationTimestamp=#{@last_update_rets}-NOW)", :count_mode => :both, :limit => 1) do |data|
      @count = $client.rets_data[:count].to_i
    end

    # quit if 0
    if @count == nil
      abort("No properties to update, quitting!")
    else
      puts "#{@count} properties to update. Proceeding..."
    end

    # populate fields
    csv = CSV.read("#{Dir.pwd}/property_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # add them to database
    begin
      @counter = 0
      @new_count = 0
      @update_count = 0
      @error_count = 0
      $client.search(:search_type => :Property, :class => :RES, :query => "(ModificationTimestamp=#{@last_update_rets}-NOW)", :count_mode => :both, :limit => 500000) do |data|

        print "\r#{@counter}/#{@count}"
        if Listing.where(:ListingKey => data['ListingKey']).empty?
          @listing = Listing.new
          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @listing["#{stripped_field}"] = data["#{stripped_field}"]
          end
          if @listing.save
            @counter = @counter + 1
            @new_count = @new_count + 1
          else
            @counter = @counter + 1
            @error_count = @error_count + 1
            log_error("properties", data['ListingKey'])
          end
        else
          @listing = Listing.where(:ListingKey => data['ListingKey']).first
          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @listing["#{stripped_field}"] = data["#{stripped_field}"]
          end
          if @listing.save
            @counter = @counter + 1
            @update_count = @update_count + 1
          else
            @counter = @counter + 1
            @error_count = @error_count + 1
            log_error("properties", data['ListingKey'])
          end
        end
      end
    rescue Timeout::Error
      puts "Retrying..."
      retry
    end

    # write success to log
    puts "Writing to log..."
    log_success("properties_update_log.txt", false, false, false, true)

    # store unix timestamp
    f = File.open("#{Dir.pwd}/log/last_property_update.txt", 'a')
    f.write("#{DateTime.now.to_time.to_i}\n")
    f.close

    # all done
    puts "Updated: #{@update_count}\nNew: #{@new_count}\nErrors: #{@error_count}"
  end

  desc "update agents"
  task :agents => :environment do
    puts "attaching client..."
    client_login
    puts "getting last update time..."
    get_last_update_time("last_agent_update.txt")

    # count new agents since last_update
    puts "counting agents modified since last update..."
    $client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentSourceModificationTimestamp=#{@last_update_rets}-NOW)", :count_mode => :both, :limit => 1) do |data|
      @count = $client.rets_data[:count].to_i
    end

    # quit if 0
    if @count == nil
      abort("No agents to update, quitting!")
    else
      puts "#{@count} agents to update. Proceeding..."
    end

    # populate fields
    csv = CSV.read("#{Dir.pwd}/agent_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # build new agent query since last_update
    begin
      @counter = 0
      @new_count = 0
      @update_count = 0
      @error_count = 0
      $client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentSourceModificationTimestamp=#{@last_update_rets}-NOW)", :limit => 500000) do |data|

        print "\r#{@counter}/#{@count}"
        if Agent.where(:AgentKey => data['AgentKey']).empty?
          @agent = Agent.new
          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @agent["#{stripped_field}"] = data["#{stripped_field}"]
          end
          if @agent.save
            @counter = @counter + 1
            @new_count = @new_count + 1
          else
            @counter = @counter + 1
            @error_count = @error_count + 1
            log_error("agents", data['AgentKey'])
          end
        else
          @agent = Agent.where(:AgentKey => data['AgentKey']).first
          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @agent["#{stripped_field}"] = data["#{stripped_field}"]
          end
          if @agent.save
            @counter = @counter + 1
            @update_count = @update_count + 1
          else
            @counter = @counter + 1
            @error_count = @error_count + 1
            log_error("agents", data['AgentKey'])
          end
        end
      end 
    rescue Timeout::Error
      puts "Retrying..."
      retry
    end

    # write success to log
    puts "Writing to log..."
    log_success("agents_update_log.txt", false, false, false, true)

    # store unix timestamp
    f = File.open("#{Dir.pwd}/log/last_agent_update.txt", 'a')
    f.write("#{DateTime.now.to_time.to_i}\n")
    f.close

    # all done
    puts "Updated: #{@update_count}\nNew: #{@new_count}\nErrors: #{@error_count}"
  end

  desc "update property media"
  task :media => :environment do
    client_login
    get_last_update_time("last_property_media_update.txt")

    # count since last update
    options = {
      :search_type => :Media,
      :class => :PROP_MEDIA,
      :query => "(PropMediaModificationTimestamp=#{@last_update_rets}-NOW)", 
      :count_mode => :both, :limit => 1
    }
    $client.search(options) do |data|
      @count = $client.rets_data[:count].to_i
    end

    if @count == nil
      abort("No properties to update, quitting!")
    else
      puts "#{@count} media objects to update. Proceeding.."
    end

    # populate fields
    csv = CSV.read("#{Dir.pwd}/property_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # add them to database
    begin
      @counter = 0
      @new_count = 0
      @update_count = 0
      @error_count = 0
      options = {
        :search_type => :Media,
        :class => :PROP_MEDIA,
        :query => "(PropMediaModificationTimestamp=#{@last_update_rets}-NOW)",
        :limit => 500000
      }
      $client.search(options) do |data|
        print "\r#{@counter}/#{@count}"
        if PropertyMedia.where(:PropMediaKey => data['PropMediaKey']).empty?
          @prop_media = PropertyMedia.new
          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @prop_media["#{stripped_field}"] = data["#{stripped_field}"]
          end
          if @prop_media.save
            @counter = @counter + 1
            @new_count = @new_count + 1
          else
            @counter = @counter + 1
            @error_count = @error_count + 1
            log_error("prop_media", data['PropMediaKey'])
          end
        else
          @prop_media = PropertyMedia.new
          fields.each do |field|
            stripped_field = field.gsub(/'/, "")
            @prop_media["#{stripped_field}"] = data["#{stripped_field}"]
          end
          if @prop_media.save
            @counter = @counter + 1
            @update_count = @update_count + 1
          else
            @counter = @counter + 1
            @error_count = @error_count + 1
            log_error("prop_media", data['PropMediaKey'])
          end
        end
      end
    rescue Timeout::Error
      puts "Retrying..."
      retry
    end

    # write success to log
    puts "Writing to log..."
    log_success("property_media_update_log.txt", false, false, false, true)

    # store unix timestamp
    f = File.open("#{Dir.pwd}/log/last_property_media_update.txt", 'a')
    f.write("#{DateTime.now.to_time.to_i}\n")
    f.close

    # all done
    puts "Updated: #{@update_count}\nNew: #{@new_count}\nErrors: #{@error_count}"
  end

  def client_login
    $client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )
  end

  def get_last_update_time(filename)
    # get unix timestamp from file
    last_timestamp = `tail -n 1 #{Dir.pwd}/log/#{filename}`
    last_update = DateTime.strptime(last_timestamp.to_s, '%s')

    # convert to RETS datetime
    @last_update_rets = last_update.strftime("%Y-%m-%dT%H:%M:%S")
  end


  def log_success(file, year, month, span, update)
    if year == true && month == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y@%I:%M:%S")}, #{@current_year}, #{@current_month}, #{@count}, #{@counter}\n")
      f.close
    elsif year == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y@%I:%M:%S")}, #{@current_year}, #{@count}, #{@counter}\n")
      f.close
    elsif span == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y@%I:%M:%S")}, #{@last_update_rets}, #{@count}\n")
      f.close
    elsif update == true
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y@%I:%M:%S")}, #{@last_update_rets}, #{@new_count}, #{@update_count}\n")
      f.close
    else
      f = File.open("#{Dir.pwd}/log/#{file}", 'a')
      f.write("#{Time.now.strftime("%m-%d-%Y@%I:%M:%S")}, #{@count}\n")
      f.close
    end
  end

  def log_error(task, key)
    f = File.open("#{Dir.pwd}/log/update_errors.csv", 'a')
    f.write("#{Time.now.strftime("$m-%d-%Y@%I:%M:%S")}, #{task}, #{key}")
    f.close
  end

end
