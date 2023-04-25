require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
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
  let(:invalid_credentials) do
    {
      user: {
        email: user.email,
        password: 'wrong_password'
      }
    }
  end

  describe 'User sign in' do
    context 'with valid credentials' do
      before { post user_session_path, params: valid_credentials }

      it 'authenticates the user' do
        follow_redirect!
        expect(response.body).to include("Dashboard")
        expect(controller.current_user).to eq(user)
      end
    end

    context 'with invalid credentials' do
      before { post user_session_path, params: invalid_credentials }

      it 'does not authenticate the user' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(controller.current_user).to be_nil
      end
    end
  end
end
