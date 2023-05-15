# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search API', type: :request do
  describe 'GET /api/links/v1/search' do
    let!(:links) { FactoryBot.create_list(:link, 5) }
    let!(:link) { FactoryBot.create(:link, title: 'Example', page: 'https://example.com') }
    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    before(:each) do
        get '/api/v1/links/search', params: { term: term }, headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }, as: :json
    end

    context 'with a valid search term' do
      let(:term) { 'example' }

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the matching links' do
        expect(response.body).to eq([link].to_json)
      end
    end

    context 'with an invalid search term' do
      let(:term) { 'invalid' }

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns JSON format' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns an empty array' do
        expect(response.body).to eq('[]')
      end
    end
  end
end
