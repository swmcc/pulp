# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseApiToken, type: :model do
  subject { build(:devise_api_token) }

  describe 'validations' do
    it { should validate_presence_of(:access_token) }
    it { should validate_presence_of(:expires_in) }
    it { should validate_presence_of(:resource_owner_id) }
    it { should validate_presence_of(:resource_owner_type) }
    it { should validate_presence_of(:refresh_token) }
  end

  describe '#still_valid?' do
    context 'when the token exists and not expired' do
      let(:token) { create(:devise_api_token) }

      it 'returns true if token is still valid' do
        expect(token.still_valid?).to eq(true)
      end
    end

    context 'when the token is still valid but expired' do
      let(:token) { create(:devise_api_token, created_at: 2.hours.ago) }

      it 'returns false if token is expired' do
        expect(token.still_valid?).to eq(false)
      end
    end
  end

  describe '#expires_at' do
    let(:token) { create(:devise_api_token) }

    it 'returns the time when the token expires' do
      expect(token.expires_at).to eq(token.created_at + token.expires_in)
    end
  end
end
