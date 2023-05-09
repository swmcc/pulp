# frozen_string_literal: true

module Api
  module V1
    class GroupsController < BaseController
      def index
        groups = Group.all

        if groups
          render json: { data: groups }, status: :ok
        else
          render json: { error: 'There are no groups' }, status: :unprocessable_entity
        end
      end

      def grouped_commits
        grouped_commits = Commit.group(:repo_name).order(commit_date: :desc)
        render json: { data: grouped_commits }, status: :ok
      end
    end
  end
end
