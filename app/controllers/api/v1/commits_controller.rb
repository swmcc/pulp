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

      def grouped_by_repo
        grouped_commits = Commit.grouped_by_repo_and_date
        render json: { data: grouped_commits.to_json }, status: :ok
      end

      def by_date
        date = begin
          params[:date].to_date
        rescue StandardError
          nil
        end
        if date
          commits = Commit.where(commit_date: date.beginning_of_day..date.end_of_day)
          render json: { data: commits }, status: :ok
        else
          render json: { error: 'Invalid date' }, status: :bad_request
        end
      end

      private

      def commit_params
        params.require(:commit).permit(:repo_name, :message, :sha, :commit_date)
      end
    end
  end
end
