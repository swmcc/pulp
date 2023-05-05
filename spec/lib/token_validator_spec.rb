# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TokenValidator, type: :helper do
  let(:token) { create(:devise_api_token) }
  let(:expired_token) { create(:devise_api_token, :expired) }

  describe '.validate' do
    context 'when token is valid' do
      it 'returns true' do
        expect(TokenValidator.validate(token.access_token)).to eq(true)
      end
    end

    context 'when token does not exist' do
      it 'returns false' do
        expect(TokenValidator.validate('invalid_token')).to eq(false)
      end
    end

    context 'when token is expired' do
      it 'returns false' do
        expect(TokenValidator.validate(expired_token.access_token)).to eq(false)
      end
    end

    context 'when token is empty' do
      it 'returns false' do
        expect(TokenValidator.validate('')).to eq(false)
      end
    end

    context 'when token is nil' do
      it 'returns false' do
        expect(TokenValidator.validate(nil)).to eq(false)
      end
    end
  end
end
