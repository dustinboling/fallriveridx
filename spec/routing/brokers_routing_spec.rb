require "spec_helper"

describe BrokersController do
  describe "routing" do

    it "routes to #index" do
      get("/brokers").should route_to("brokers#index")
    end

    it "routes to #new" do
      get("/brokers/new").should route_to("brokers#new")
    end

    it "routes to #show" do
      get("/brokers/1").should route_to("brokers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/brokers/1/edit").should route_to("brokers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/brokers").should route_to("brokers#create")
    end

    it "routes to #update" do
      put("/brokers/1").should route_to("brokers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/brokers/1").should route_to("brokers#destroy", :id => "1")
    end

  end
end
