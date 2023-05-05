# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include TokenValidator

      before_action :authenticate_request

      def authenticate_request
        return if TokenValidator.validate(extract_token_from_header)

        render json: { error: 'Not Authorised' }, status: :unauthorized
      end

      private

      def extract_token_from_header
        request.headers['Authentication']
      end
    end
  end
end
