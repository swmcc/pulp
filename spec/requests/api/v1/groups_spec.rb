# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/groups', type: :request do
  context 'when signed in' do
    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }
    let!(:groups) { create_list(:group, 5) }

    before do
      get api_v1_groups_url,
          headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'returns the correct JSON payload' do
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to be_an(Array)
      expect(json_response['data'].size).to eq(5)

      groups.zip(json_response['data']).each do |record, json_record|
        expect(json_record['id']).to eq(record.id)
        expect(json_record['name']).to eq(record.name)
        expect(json_record['notes']).to eq(record.notes)
      end
    end
  end

  context 'when passed an expired token' do
    let(:user) { create(:user) }
    let(:invalid_token) { create(:devise_api_token, created_at: 2.days.ago, resource_owner_id: user.id) }

    before do
      get api_v1_groups_url,
          headers: { 'Authentication': invalid_token.access_token, 'Content-Type': 'application/json' }
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns an error message' do
      expect(response.body).to match(/Not Authorised/)
    end
  end

  context 'when passed an invalid token' do
    let(:user) { create(:user) }

    before do
      get api_v1_groups_url,
          headers: { 'Authentication': 'something', 'Content-Type': 'application/json' }
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns an error message' do
      expect(response.body).to match(/Not Authorised/)
    end
  end

  context 'when not signed in' do
    before { get api_v1_groups_url }

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
