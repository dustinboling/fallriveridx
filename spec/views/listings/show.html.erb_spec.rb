require 'spec_helper'

describe "listings/show" do
  before(:each) do
    @listing = assign(:listing, stub_model(Listing,
      :street1 => "Street1",
      :street2 => "Street2",
      :city => "City",
      :state => "State",
      :zip => 1,
      :beds => 1,
      :baths => 1,
      :agent_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Street1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Street2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
