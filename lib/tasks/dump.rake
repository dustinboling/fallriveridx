namespace :dump do

  csv_fields = [ "AgentFirstName", "AgentLastName", "AgentFullName", "AgentOfficeID", "AgentRole", "AgentEmail", "AgentPostalCode", "AgentFullStreetAddress", "AgentCityName", "AgentState", "AgentHomePhone", "AgentDirectPhone", "AgentCellPhone", "AgentStatus", "OfficeName" ]
  rails_tmp_path = "#{Rails.root}/tmp"

  desc "dumps all active agents to a csv"
  task :all_agents => :environment do
    agents = get_all_active_agents
    
    CSV.open("#{rails_tmp_path}/all_agents_#{Time.now.to_i}.csv", "wb") do |csv|
      csv << csv_fields

      agents.each do |a|
        row = compile_row(a)
        csv << row
      end
    end
  end

  desc "dumps the agents from newport beach to a csv file"
  task :nb_agents => :environment do
    # agents = Agent.where(:AgentPostalCode => "92657".."92663", :AgentStatus => 'Active')
    agents = get_agents_for_zip_range("92657", "92663")

    CSV.open("#{rails_tmp_path}/newport_beach.csv", "wb") do |csv|
      csv << csv_fields

      agents.each do |a|
        row = compile_row(a)
        csv << row
      end
    end
  end

  desc "dumps agents for a selected zip range"
  task :zip_range, [:zip1, :zip2, :filename] => :environment do |t, args|
    # puts args.zip2  
    agents = get_agents_for_zip_range(args.zip1, args.zip2)
    
    CSV.open("#{rails_tmp_path}/#{args.filename}.csv", "wb") do |csv|
      csv << csv_fields

      agents.each do |a|
        row = compile_row(a)
        csv << row
      end
    end
  end

  def compile_row(a)
    row = [ 
      a.AgentFirstName, 
      a.AgentLastName,
      a.AgentFullName,
      a.AgentOfficeID,
      a.AgentRole,
      a.AgentEmail,
      a.AgentPostalCode,
      a.AgentFullStreetAddress,
      a.AgentCityName,
      a.AgentState,
      a.AgentHomePhone,
      a.AgentDirectPhone,
      a.AgentCellPhone,
      a.AgentStatus,
      a.OfficeName
    ]
  end

  def get_agents_for_zip_range(zip1, zip2)
    agents = Agent.where(:AgentPostalCode => zip1..zip2, :AgentStatus => "Active")
  end
  
  def get_all_active_agents
    Agent.where(:AgentStatus => "Active")
  end
end
