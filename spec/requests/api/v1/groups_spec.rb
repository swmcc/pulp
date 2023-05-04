# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/groups', type: :request do
  context 'when signed out' do
    describe 'GET /api/v1/groups' do
      let!(:groups) { create_list(:group, 5) }

      before { get api_v1_groups_url }

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
  end
end
