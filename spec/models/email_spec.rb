# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Email, type: :model do
  subject(:email) { build(:email) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:app) }

    it 'is valid with valid attributes' do
      expect(email).to be_valid
    end
  end
end
