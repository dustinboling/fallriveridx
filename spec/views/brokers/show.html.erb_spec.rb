require 'spec_helper'

describe "brokers/show" do
  before(:each) do
    @broker = assign(:broker, stub_model(Broker,
      :name => "Name",
      :street1 => "Street1",
      :street2 => "Street2",
      :city => "City",
      :state => "State",
      :zip => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
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
  end
end
