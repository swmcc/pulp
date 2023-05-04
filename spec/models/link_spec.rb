# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  subject(:link) { build(:link) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:page) }

    it 'is valid with valid attributes' do
      expect(link).to be_valid
    end

    it 'is not valid without a title' do
      link.title = nil
      expect(link).not_to be_valid
    end

    it 'is not valid without a page' do
      link.page = nil
      expect(link).not_to be_valid
    end
  end
end
