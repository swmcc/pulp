# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Not Found API request', type: :request do
  let(:user) { create(:user) }
  let(:valid_token) { create(:devise_api_token, resource_owner_id: user.id) }

  before do
    get '/api/v1/nonexistent_route',
        headers: { 'Authentication': valid_token.access_token, 'Content-Type': 'application/json' }
  end

  it 'returns a 404 status code and JSON error message for nonexistent routes' do
    expect(response).to have_http_status(404)
    json = JSON.parse(response.body)
    expect(json['error']).to eq('Resource not found')
  end
end
