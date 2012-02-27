require 'spec_helper'

describe "agents/index" do
  before(:each) do
    assign(:agents, [
      stub_model(Agent,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email"
      ),
      stub_model(Agent,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email"
      )
    ])
  end

  it "renders a list of agents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
