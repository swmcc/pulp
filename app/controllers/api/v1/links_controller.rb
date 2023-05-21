# frozen_string_literal: true

module Api
  module V1
    class LinksController < BaseController
      def create
        @link = Link.new(link_params)

        if @link.save
          render json: @link, status: :created
        else
          render json: @link.errors, status: :bad_request
        end
      end

      def search
        @links = Link.search_on_title_and_page(params[:term])

        render json: @links
      end

      private

      def link_params
        params.require(:link).permit(:title, :page)
      end
    end
  end
end
