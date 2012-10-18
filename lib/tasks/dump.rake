namespace :dump do

  csv_fields = [ "AgentFirstName", "AgentLastName", "AgentFullName", "AgentOfficeID", "AgentRole", "AgentEmail", "AgentPostalCode", "AgentFullStreetAddress", "AgentPostalCode", "AgentCityName", "AgentState", "AgentHomePhone", "AgentDirectPhone", "AgentCellPhone", "AgentStatus", "OfficeName", "AgentRole" ]

  desc "dumps all active agents to a csv"
  task :all_agents => :environment do
    rails_tmp_path = "#{Rails.root}/tmp"
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
    rails_tmp_path = "#{Rails.root}/tmp"
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
      a.AgentPostalCode,
      a.AgentCityName,
      a.AgentState,
      a.AgentHomePhone,
      a.AgentDirectPhone,
      a.AgentCellPhone,
      a.AgentStatus,
      a.OfficeName,
      a.AgentRole
    ]
  end

  def get_agents_for_zip_range(zip1, zip2)
    agents = Agent.where(:AgentPostalCode => zip1..zip2, :AgentStatus => "Active")
  end
  
  def get_all_active_agents
    Agent.where(:AgentStatus => "Active")
  end
end
