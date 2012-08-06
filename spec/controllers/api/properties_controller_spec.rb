require 'spec_helper'

describe Api::PropertiesController do
  describe "GET index" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "renders some json for an authenticated user" do

    end
  end

end
