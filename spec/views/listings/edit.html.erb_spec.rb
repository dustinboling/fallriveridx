require 'spec_helper'

describe "listings/edit" do
  before(:each) do
    @listing = assign(:listing, stub_model(Listing,
      :street1 => "MyString",
      :street2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => 1,
      :beds => 1,
      :baths => 1,
      :agent_id => 1
    ))
  end

  it "renders the edit listing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => listings_path(@listing), :method => "post" do
      assert_select "input#listing_street1", :name => "listing[street1]"
      assert_select "input#listing_street2", :name => "listing[street2]"
      assert_select "input#listing_city", :name => "listing[city]"
      assert_select "input#listing_state", :name => "listing[state]"
      assert_select "input#listing_zip", :name => "listing[zip]"
      assert_select "input#listing_beds", :name => "listing[beds]"
      assert_select "input#listing_baths", :name => "listing[baths]"
      assert_select "input#listing_agent_id", :name => "listing[agent_id]"
    end
  end
end
