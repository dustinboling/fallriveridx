require 'spec_helper'

describe "brokers/new" do
  before(:each) do
    assign(:broker, stub_model(Broker,
      :name => "MyString",
      :street1 => "MyString",
      :street2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => 1
    ).as_new_record)
  end

  it "renders new broker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => brokers_path, :method => "post" do
      assert_select "input#broker_name", :name => "broker[name]"
      assert_select "input#broker_street1", :name => "broker[street1]"
      assert_select "input#broker_street2", :name => "broker[street2]"
      assert_select "input#broker_city", :name => "broker[city]"
      assert_select "input#broker_state", :name => "broker[state]"
      assert_select "input#broker_zip", :name => "broker[zip]"
    end
  end
end
