require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    xit "returns http success" do
      get "/dashboard"
      expect(response).to have_http_status(:found)
      expect(response.body).to include("Dashboard")
    end
  end
end
