
# frozen_string_literal: true

module Api
  module V1
    class CommitsController < BaseController
      def create
        commit = Commit.new(commit_params)

        if commit.save
          render json: commit, status: :created
        else
          render json: { errors: commit.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def commit_params
        params.require(:commit).permit(:repo_name, :message, :sha, :commit_date)
      end
    end
  end
end
