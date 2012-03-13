require 'spec_helper'

describe "Brokers" do
  before :each do 
    Broker.create!(:name => "Some Broker, Inc.", :street1 => "1665 Quail St", :street2 => "Suite 201", :city => "Newport Beach", :state => "CA", :zip => "92660", :phone => "714-512-2526", :license_number => "A000022")
  end
  
  describe "GET /brokers" do
    it "gets a list of agents" do      
      visit brokers_path
      page.should have_content("Some Broker, Inc.")
      page.should have_content("1665 Quail St")
      page.should have_content("Suite 201")
      page.should have_content("Newport Beach")
      page.should have_content("CA")
      page.should have_content("92660")
      page.should have_content("714-512-2526")
      page.should have_content("A000022")
    end
  end
  
  describe "POST /brokers" do
    it "creates a broker" do
      visit brokers_path
      page.should have_content("Some Broker, Inc.")
      page.should have_content("1665 Quail St")
      page.should have_content("Suite 201")
      page.should have_content("Newport Beach")
      page.should have_content("CA")
      page.should have_content("92660")
      page.should have_content("714-512-2526")
      page.should have_content("A000022")
    end
  end
end
