# frozen_string_literal: true

class DeviseApiToken < ApplicationRecord
     validates :resource_owner_type, presence: true
     validates :resource_owner_id, presence: true
     validates :access_token, presence: true
     validates :refresh_token, presence: true
     validates :expires_in, presence: true
end
