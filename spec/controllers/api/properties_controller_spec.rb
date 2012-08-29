require 'spec_helper'

describe Api::PropertiesController do
  ###
  # check for 200 ok
  ###
  describe "GET index" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "renders some json for an authenticated user" do
    end
  end

  describe "GET show" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET invalid_parameters" do
    it "should be successful" do
      get 'invalid_parameters'
      response.should be_success
    end
  end

  ###
  # check action functionality
  ###
  describe "validate_params" do
    it "should accept good parameters" do
    end

    it "should discard unneccessary params" do
    end

    it "should raise error on bad parameters" do
    end
  end

  describe "authenticate_referer" do
    it "should make a user submit a token" do
    end

    it "should reject a null token" do
    end

    it "should reject a user who has not activated the referring site" do
    end

    it "should reject a user whose referring site does not equal site_url in database" do
    end
  end
end
