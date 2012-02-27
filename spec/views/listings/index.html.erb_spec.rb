require 'spec_helper'

describe "listings/index" do
  before(:each) do
    assign(:listings, [
      stub_model(Listing,
        :street1 => "Street1",
        :street2 => "Street2",
        :city => "City",
        :state => "State",
        :zip => 1,
        :beds => 1,
        :baths => 1,
        :agent_id => 1
      ),
      stub_model(Listing,
        :street1 => "Street1",
        :street2 => "Street2",
        :city => "City",
        :state => "State",
        :zip => 1,
        :beds => 1,
        :baths => 1,
        :agent_id => 1
      )
    ])
  end

  it "renders a list of listings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Street1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Street2".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
