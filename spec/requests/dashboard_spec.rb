# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  describe 'GET /index' do
    context 'when signed in' do
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
      it 'returns http success' do
        get '/dashboard'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Dashboard')
      end
    end

    context 'when not signed in' do
      it 'returns to the homepage' do
        get '/dashboard'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
