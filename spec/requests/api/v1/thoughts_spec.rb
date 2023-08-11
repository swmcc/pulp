#! frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Thoughts', type: :request do
  describe 'GET /api/v1/weekly' do
    let!(:thought_1) { create(:thought, sparked_at: Date.today.beginning_of_week(:sunday)) }
    let!(:thought_2) { create(:thought, sparked_at: Date.today.beginning_of_week(:sunday) + 1.day) }

    let(:user) { create(:user) }
    let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

    before do
      get '/api/v1/thoughts/weekly',
          headers: { 'Authentication': valid_token.access_token, Content_Type: 'application/json' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    xit 'returns thoughts grouped by week' do
      data = JSON.parse(response.body)
      #expect(data.keys).to contain_exactly(Date.today.beginning_of_week(:sunday).to_s)
      expect(data[Date.today.beginning_of_week(:sunday).to_s]).to contain_exactly(
        a_hash_including('id' => thought_1.id),
        a_hash_including('id' => thought_2.id)
      )
    end
  end
end
