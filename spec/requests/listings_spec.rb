require 'spec_helper'

describe "Listings" do
  before :each do
    Listing.create!(:street1 => "101 Cool House Road", :street2 => "Apt 7", :city => "Newport Beach", :state => "CA", :zip => "92660", :beds => "3", :baths => "2", :agent_id => "1")
  end
  
  describe "GET /listings" do
    it "lists the listings" do
      visit listings_path
      page.should have_content("101 Cool House Road")
      page.should have_content("Apt 7")
      page.should have_content("Newport Beach")      
      page.should have_content("CA")
      page.should have_content("92660")      
      page.should have_content("3")
      page.should have_content("2")          
    end
  end
  
  describe "POST /listings" do
    it "creates a new listing" do
      visit listings_path
      page.should have_content("101 Cool House Road")
      page.should have_content("Apt 7")
      page.should have_content("Newport Beach")      
      page.should have_content("CA")
      page.should have_content("92660")      
      page.should have_content("3")
      page.should have_content("2")
    end
  end
end
