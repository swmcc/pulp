# frozen_string_literal: true

class DeviseApiToken < ApplicationRecord
  validates :resource_owner_type, presence: true
  validates :resource_owner_id, presence: true
  validates :access_token, presence: true
  validates :refresh_token, presence: true
  validates :expires_in, presence: true

  def still_valid?
    expires_at > Time.now
  end

  def expires_at
    created_at + expires_in
  end
end
