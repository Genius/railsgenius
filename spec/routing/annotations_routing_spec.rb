require "spec_helper"

describe AnnotationsController do
  describe "routing" do

    it "routes to #index" do
      get("/annotations").should route_to("annotations#index")
    end

    it "routes to #new" do
      get("/annotations/new").should route_to("annotations#new")
    end

    it "routes to #show" do
      get("/annotations/1").should route_to("annotations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/annotations/1/edit").should route_to("annotations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/annotations").should route_to("annotations#create")
    end

    it "routes to #update" do
      put("/annotations/1").should route_to("annotations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/annotations/1").should route_to("annotations#destroy", :id => "1")
    end

  end
end
