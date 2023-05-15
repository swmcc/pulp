# frozen_string_literal: true

module Api
  module V1
    class LinksController < BaseController
      def search
        @links = Link.search_on_title_and_page(params[:term])

        render json: @links
      end
    end
  end
end
