module Presenters
  module Cells
    class PresenterCell < Cell::ViewModel
      delegate :current_user, :to => :controller

      def featured
        render
      end

      def list
        render
      end

      private

      property :name
      property :bio
      property :title
      property :photo_url

      def twitter_url
        "http://twitter.com/#{model.twitter}"
      end

      def github_url
        "http://github.com/#{model.github}"
      end

      def edit_path
        edit_presenter_path(model)
      end

      def videos
        "99 Videos"
      end
    end
  end
end
