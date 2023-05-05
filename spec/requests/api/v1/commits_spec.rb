# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Commits', type: :request do
  describe 'POST /api/v1/commits' do
    let(:valid_payload) do
      {
        commit: {
          repo_name: 'user/repo',
          message: 'Add new feature',
          sha: 'a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1',
          commit_date: '2023-01-01T12:00:00Z'
        }
      }
    end

    let(:invalid_payload) do
      {
        commit: {
          repo_name: '',
          message: '',
          sha: '',
          commit_date: ''
        }
      }
    end

    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    context 'with valid payload' do
      it 'creates a new commit and returns a success status' do
        expect {
          post '/api/v1/commits', params: valid_payload, headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
        }.to change(Commit, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid payload' do
      it 'does not create a new commit and returns an error status' do
        expect {
          post '/api/v1/commits', params: invalid_payload, headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
        }.not_to change(Commit, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when passed no token with a valid payload' do
       it 'returns status code 401' do
           post '/api/v1/commits', params: valid_payload, headers: { 'Content-Type': 'application/json' }
         expect(response).to have_http_status(:unauthorized)
       end
    end
  end
end
