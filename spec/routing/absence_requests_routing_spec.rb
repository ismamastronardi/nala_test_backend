require "rails_helper"

RSpec.describe AbsenceRequestsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/absence_requests").to route_to("absence_requests#index")
    end

    it "routes to #show" do
      expect(get: "/absence_requests/1").to route_to("absence_requests#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/absence_requests").to route_to("absence_requests#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/absence_requests/1").to route_to("absence_requests#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/absence_requests/1").to route_to("absence_requests#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/absence_requests/1").to route_to("absence_requests#destroy", id: "1")
    end
  end
end
