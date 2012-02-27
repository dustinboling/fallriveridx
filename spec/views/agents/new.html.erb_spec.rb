require 'spec_helper'

describe "agents/new" do
  before(:each) do
    assign(:agent, stub_model(Agent,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new agent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agents_path, :method => "post" do
      assert_select "input#agent_first_name", :name => "agent[first_name]"
      assert_select "input#agent_last_name", :name => "agent[last_name]"
      assert_select "input#agent_email", :name => "agent[email]"
    end
  end
end
