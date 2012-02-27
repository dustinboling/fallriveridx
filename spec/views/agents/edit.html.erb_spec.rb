require 'spec_helper'

describe "agents/edit" do
  before(:each) do
    @agent = assign(:agent, stub_model(Agent,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit agent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agents_path(@agent), :method => "post" do
      assert_select "input#agent_first_name", :name => "agent[first_name]"
      assert_select "input#agent_last_name", :name => "agent[last_name]"
      assert_select "input#agent_email", :name => "agent[email]"
    end
  end
end
