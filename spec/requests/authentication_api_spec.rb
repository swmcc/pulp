# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api Authentication', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/users/tokens/sign_in' }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  describe 'POST /users/tokens/sign_in' do
    context 'when valid params are sent' do
      before { post url, params: params }

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user email' do
        expect(json['resource_owner']['email']).to eq(user.email)
      end

      it 'returns an access-token' do
        expect(json['token']).to be_present
      end

      it 'returns a token-type' do
        expect(json['token_type']).to be_present
        expect(json['token_type']).to eq('Bearer')
      end
    end

    context 'when invalid params are sent' do
      before { post url, params: { email: '', password: '' } }

      it 'returns http bad_request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages' do
        expect(json['error']).to be_present
      end
    end

    context 'when valid params are sent' do
      before { post '/users/tokens/sign_in', params: params }

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user email' do
        expect(json['resource_owner']['email']).to eq(user.email)
      end
    end

    context 'when invalid params are sent' do
      before { post '/users/tokens/sign_in', params: { email: '', password: '' } }

      it 'returns http bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
