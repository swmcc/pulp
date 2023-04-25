require 'rails_helper'

RSpec.describe "Welcome", type: :request do
  describe "GET /" do
    context "when signed in" do
      let(:user) { create(:user) }
      let(:sign_in_url) { new_user_session_path }
      let(:valid_credentials) do
        {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      before { post user_session_path, params: valid_credentials }

      it "returns http success" do
        get "/"
        expect(response).to have_http_status(:success)
        expect(response.body).to include("SWM's kitchen sink of apps and utilities in one place.")
      end
    end

    context "when signed out" do
      it "redirects to sign in" do
        get "/"
        expect(response).to have_http_status(:success)
        expect(response.body).to include("SWM's kitchen sink of apps and utilities in one place.")
      end
    end
  end
end
