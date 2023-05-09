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
        expect do
          post '/api/v1/commits', params: valid_payload,
                                  headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
        end.to change(Commit, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid payload' do
      it 'does not create a new commit and returns an error status' do
        expect do
          post '/api/v1/commits', params: invalid_payload,
                                  headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
        end.not_to change(Commit, :count)

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

  describe 'GET /api/v1/commits/grouped_by_repo' do
    let!(:commit1) { create(:commit, repo_name: 'Repo1', commit_date: DateTime.now) }
    let!(:commit2) { create(:commit, repo_name: 'Repo2', commit_date: DateTime.now - 1.day) }
    let!(:commit3) { create(:commit, repo_name: 'Repo1', commit_date: DateTime.now - 2.days) }

    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    before do
      get '/api/v1/commits/grouped_by_repo',
          headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
    end

    it 'returns JSON' do
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns the correct JSON elements' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response['data']).to include('Repo1', 'Repo2')
      expect(parsed_response['data']).not_to include('Repo3', 'Repo4')
      expect(parsed_response['data']).to include(commit1.sha, commit3.message)
    end
  end

  describe 'GET /api/v1/commits/by_date' do
    context 'with valid date' do
      let!(:commit1) { create(:commit, commit_date: DateTime.now) }
      let!(:commit2) { create(:commit, commit_date: DateTime.now) }
      let!(:commit3) { create(:commit, commit_date: DateTime.now - 1.day) }
      let!(:commit4) { create(:commit, commit_date: DateTime.now - 2.days) }

      let(:user) { create(:user) }
      let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

      before do
        get "/api/v1/commits/by_date/#{Date.current}",
            headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
      end

      it 'returns JSON' do
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns commits for the given date' do
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).not_to be_empty
        expect(parsed_response['data'].size).to eq(2)
      end
    end

    context 'with invalid date' do
      let(:user) { create(:user) }
      let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

      before do
        get '/api/v1/commits/by_date/invalid_date',
            headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Invalid date/)
      end
    end
  end
end
