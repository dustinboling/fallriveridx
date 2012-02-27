require 'spec_helper'

describe "Listings" do
  describe "GET /listings" do
    it "lists the listings" do
      Listing.create!(:street1 => "101 Cool House Road", :street2 => "Apt 7", :city => "Newport Beach", :state => "CA", :zip => "92660", :beds => "3", :baths => "2", :agent_id => "1")
      get listings_path
      response.body.should include("101 Cool House Road")
      response.body.should include("Apt 7")
      response.body.should include("Newport Beach")      
      response.body.should include("CA")
      response.body.should include("92660")      
      response.body.should include("3")
      response.body.should include("2")          
    end
  end
  
  describe "POST /listings" do
    it "creates a new listing" do
      post_via_redirect listings_path, :listing => {:street1 => "101 Cool House Road", :street2 => "Apt 7", :city => "Newport Beach", :state => "CA", :zip => "92660", :beds => "3", :baths => "2", :agent_id => "1"}
      response.body.should include("101 Cool House Road")
      response.body.should include("Apt 7")
      response.body.should include("Newport Beach")      
      response.body.should include("CA")
      response.body.should include("92660")      
      response.body.should include("3")
      response.body.should include("2")
    end
  end
end
