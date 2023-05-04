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
    end
  end
end
