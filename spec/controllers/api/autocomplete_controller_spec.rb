require 'spec_helper'

describe Api::AutocompleteController do

  describe "GET cities" do
    it "returns http success" do
      get :cities
      response.should be_success
    end
  end

  describe "GET tracts" do
    it "returns http success" do
      get :tracts
      response.should be_success
    end
  end

  describe "GET communities" do
    it "returns http success" do
      get :communities
      response.should be_success
    end
  end

  describe "GET combined" do
    it "returns http success" do
      get :combined
      response.should be_success
    end
  end

end
