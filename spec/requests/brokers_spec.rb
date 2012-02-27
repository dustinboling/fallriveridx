require 'spec_helper'

describe "Brokers" do
  describe "GET /brokers" do
    it "gets a list of agents" do
      Broker.create!(:name => "Some Broker, Inc.", :street1 => "1665 Quail St", :street2 => "Suite 201", :city => "Newport Beach", :state => "CA", :zip => "92660", :phone => "714-512-2526", :license_number => "A000022")
      get brokers_path
      response.body.should include("Some Broker, Inc.")
      response.body.should include("1665 Quail St")
      response.body.should include("Suite 201")
      response.body.should include("Newport Beach")
      response.body.should include("CA")
      response.body.should include("92660")
      response.body.should include("714-512-2526")
      response.body.should include("A000022")
    end
  end
  
  describe "POST /brokers" do
    it "creates a broker" do
      post_via_redirect brokers_path, :broker => {:name => "Some Broker, Inc.", :street1 => "1665 Quail St", :street2 => "Suite 201", :city => "Newport Beach", :state => "CA", :zip => "92660", :phone => "714-512-2526", :license_number => "A000022"}
      response.body.should include("Some Broker, Inc.")
      response.body.should include("1665 Quail St")
      response.body.should include("Suite 201")
      response.body.should include("Newport Beach")
      response.body.should include("CA")
      response.body.should include("92660")
      response.body.should include("714-512-2526")
      response.body.should include("A000022")
    end
  end
end
