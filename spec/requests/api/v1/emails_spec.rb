# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Emails', type: :request do
  describe 'POST /api/v1/emails' do
    let(:valid_payload) do
      {
        email: {
          email: 'something@swm.cc',
          app: 'swm.cc',
        }
      }
    end

    let(:invalid_payload) do
      {
        email: {
          email: '',
          app: '',
        }
      }
    end

    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    context 'with valid payload' do
      it 'creates a new commit and returns a success status' do
        expect do
          post '/api/v1/emails', params: valid_payload,
                                  headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
        end.to change(Email, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid payload' do
      it 'does not create a new email and returns an error status' do
        expect do
          post '/api/v1/emails', params: invalid_payload,
                                  headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
        end.not_to change(Email, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when passed no token with a valid payload' do
      it 'returns status code 401' do
        post '/api/v1/emails', params: valid_payload, headers: { 'Content-Type': 'application/json' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
