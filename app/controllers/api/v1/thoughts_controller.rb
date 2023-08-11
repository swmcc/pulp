# frozen_string_literal: true

module Api
  module V1
    class ThoughtsController < BaseController
      def weekly
        start_date = Date.today.beginning_of_week(:sunday)
        end_date = start_date.end_of_week(:sunday)
        thoughts = Thought.where(sparked_at: start_date..end_date).order(:sparked_at)

        #render json: thoughts.group_by_week(:sparked_at, start_day: :sunday).as_json
        render json: thoughts.group_by { |t| t.sparked_at.beginning_of_week(:sunday) }.as_json
      end
    end
  end
end
