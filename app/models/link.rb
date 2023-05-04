# frozen_string_literal: true

class Link < ApplicationRecord
  validates :title, presence: true
  validates :page, presence: true
end
