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
end
