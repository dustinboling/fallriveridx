namespace :update do

  desc "update properties"
  task :properties => :environment do
    # set up client
    $client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )

    # get unix timestamp from file
    last_timestamp = `tail -n 1 #{Dir.pwd}/log/last_property_update.txt`
    last_update = DateTime.strptime(last_timestamp.to_s, '%s')

    # convert last_update to RETS datetime
    last_update_rets = last_update.strftime("%Y-%m-%dT%H:%M:%S")

    # count since last update
    $client.search(:search_type => :Property, :class => :RES, :query => "(ModificationTimestamp=#{last_update_rets}-NOW)", :count_mode => :both, :limit => 1) do |data|
      @count = $client.rets_data[:count].to_i
    end

    # quit if 0
    if @count == 0
      abort("No agents to update, quitting!")
    else
      puts "#{@count} properties to update. Proceeding..."
    end

    # populate fields
    csv = CSV.read("#{Dir.pwd}/property_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # add them to database
    $client.search(:search_type => :Property, :class => :RES, :query => "(ModificationTimestamp=#{last_update_rets}-NOW)", :count_mode => :both, :limit => 500000) do |data|
      if Listing.where(:ListingKey => data['ListingKey']).empty?
        @listing = Listing.new
        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @listing["#{stripped_field}"] = data["#{stripped_field}"]
        end
        @listing.save
      else
        @listing = Listing.where(:ListingKey => data['ListingKey']).first
        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @listing["#{stripped_field}"] = data["#{stripped_field}"]
        end
        @listing.save
      end
    end
  end

  desc "update agents"
  task :agents => :environment do
    # set up client
    $client = RETS::Client.login(
      :url => "http://carets.retscure.com:6103/platinum/login",
      :username => "CARDUSTINBOLINGASSOC",
      :password => "sterac1071",
      :useragent => { :name => "CARETS-General/1.0" }
    )

    # get unix timestamp from file
    last_timestamp = `tail -n 1 #{Dir.pwd}/log/last_agent_update.txt`
    last_update = DateTime.strptime(last_timestamp.to_s, '%s')

    # convert to RETS datetime
    last_update_rets = last_update.strftime("%Y-%m-%dT%H:%M:%S")

    # count new agents since last_update
    $client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentSourceModificationTimestamp=#{last_update_rets}-NOW)", :count_mode => :both, :limit => 500000) do |data|
      @count = $client.rets_data[:count].to_i
    end

    # quit if 0
    if @count == 0
      abort("No agents to update, quitting!")
    else
      puts "#{@count} agents to update. Proceeding..."
    end

    # populate fields
    csv = CSV.read("#{Dir.pwd}/agent_fields.txt")
    fields = csv.shift.map { |i| i.to_s }

    # build new agent query since last_update
    $client.search(:search_type => :Agent, :class => :Agent, :query => "(AgentSourceModificationTimestamp=#{last_update_rets}-NOW)", :limit => 500000) do |data|

      if Agent.where(:AgentKey => data['AgentKey']).empty?
        @agent = Agent.new
        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @agent["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
        end
        @agent.save
      else
        @agent = Agent.where(:AgentKey => data['AgentKey']).first
        fields.each do |field|
          stripped_field = field.gsub(/'/, "")
          @agent["#{field.gsub(/'/, "")}"] = data["#{stripped_field}"]
        end
        @agent.save
      end
    end 
  end
end
