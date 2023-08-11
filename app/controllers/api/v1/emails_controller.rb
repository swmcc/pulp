# frozen_string_literal: true

module Api
  module V1
    class EmailsController < BaseController
      def create
        email = Email.new(email_params)

        print "email_params: #{email_params}\n"
        if email.save
          render json: email, status: :created
        else
          render json: { errors: email.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def email_params
        params.require(:email).permit(:email, :app)
      end
    end
  end
end
