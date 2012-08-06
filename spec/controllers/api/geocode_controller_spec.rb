require 'spec_helper'

describe Api::GeocodeController do

  describe "GET index" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET geocode" do
    it "returns http success" do
      get :geocode
      response.should be_success
    end
  end

end
