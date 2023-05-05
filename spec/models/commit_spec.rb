# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Commit, type: :model do
  subject(:commit) { build(:commit) }

  describe 'validations' do
    it { should validate_presence_of(:repo_name) }
    it { should validate_presence_of(:sha) }
    it { should validate_presence_of(:commit_date) }
    it { should validate_presence_of(:message) }

    it 'is valid with valid attributes' do
      expect(commit).to be_valid
    end

    it 'is not valid without a name' do
      commit.repo_name = nil
      expect(commit).not_to be_valid
    end
  end
end
