require 'spec_helper'

describe "Agents" do
  before :each do 
    Agent.create!(:first_name => "Gaius", :last_name => "Baltar", :email => "gaius@whatever.com", :license_number => "A0000022", :phone => "(714) 512-2526", :broker_id => "1")
  end
  
  describe "GET /agents" do
    it "gets a list of agents" do
      visit agents_path
      page.should have_content("Gaius")
      page.should have_content("Baltar")
      page.should have_content("gaius@whatever.com")
      page.should have_content("A0000022")
      page.should have_content("(714) 512-2526")
      page.should have_content("1")
    end
  end
  
  describe "POST /agents" do
    it "creates an agent" do
      visit agents_path
      page.should have_content("Gaius")
      page.should have_content("Baltar")
      page.should have_content("gaius@whatever.com")
      page.should have_content("A0000022")
      page.should have_content("(714) 512-2526")
      page.should have_content("1")
    end
  end
  
end