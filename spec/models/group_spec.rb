# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  subject(:group) { build(:group) }

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'is valid with valid attributes' do
      expect(group).to be_valid
    end

    it 'is not valid without a name' do
      group.name = nil
      expect(group).not_to be_valid
    end

    it 'is valid without a note' do
      group.notes = nil
      expect(group).to be_valid
    end
  end
end
