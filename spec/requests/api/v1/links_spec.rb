# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search API', type: :request do
  describe 'GET /api/links/v1/search' do
    let!(:links) { FactoryBot.create_list(:link, 5) }
    let!(:link) { FactoryBot.create(:link, title: 'Example', page: 'https://example.com') }
    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    before(:each) do
      get '/api/v1/links/search', params: { term: term },
                                  headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }, as: :json
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

  describe 'POST /create' do
    let(:valid_attributes) { { page: 'https://example.com', title: 'Example' } }
    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    before(:each) do
      post api_v1_links_path, params: { link: valid_attributes },
                              headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }, as: :json
    end

    context 'with valid parameters' do
      it 'creates a new Link' do
        expect do
          post api_v1_links_path, params: { link: valid_attributes },
                                  headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }, as: :json
        end.to change(Link, :count).by(1)
      end

      it 'returns a 201 status code' do
        post api_v1_links_path, params: { link: valid_attributes },
                                headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Link and returns a 400 status code' do
        expect do
          post api_v1_links_path, params: { link: { page: '', title: '' } },
                                  headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }, as: :json
        end.to change(Link, :count).by(0)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
