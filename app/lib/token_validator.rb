# frozen_string_literal: true

module TokenValidator
  def self.validate(token)
    return false if token.nil? || token.empty?

    api_token = DeviseApiToken.find_by(access_token: token)
    return false if api_token.nil?
    return false if !api_token.still_valid?

    true
  end
end
