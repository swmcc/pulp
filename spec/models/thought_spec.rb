# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thought, type: :model do
  subject(:thought) { build(:thought) }

  describe 'validations' do
    it { should validate_presence_of(:thought) }
    it { should validate_presence_of(:sparked_at) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a thought' do
      subject.thought = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a sparked_at' do
      thought.sparked_at = nil
      expect(subject).to_not be_valid
    end
  end
end
