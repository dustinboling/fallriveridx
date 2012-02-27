require 'spec_helper'

describe "Agents" do
  
  describe "GET /agents" do
    it "gets a list of agents" do
      Agent.create!(:first_name => "Gaius", :last_name => "Baltar", :email => "gaius@whatever.com", :license_number => "A0000022", :phone => "(714) 512-2526", :broker_id => "1")
      get agents_path
      response.body.should include("Gaius")
      response.body.should include("Baltar")
      response.body.should include("gaius@whatever.com")
      response.body.should include("A0000022")
      response.body.should include("(714) 512-2526")
      response.body.should include("1")
    end
  end
  
  describe "POST /agents" do
    it "creates an agent" do
      post_via_redirect agents_path, :agent => {:first_name => "Gaius", :last_name => "Baltar", :email => "gaius@whatever.com", :license_number => "A0000022", :phone => "(714) 512-2526", :broker_id => "1"}
      response.body.should include("Gaius")
      response.body.should include("Baltar")
      response.body.should include("gaius@whatever.com")
      response.body.should include("A0000022")
      response.body.should include("(714) 512-2526")
      response.body.should include("1")
    end
  end
  
end