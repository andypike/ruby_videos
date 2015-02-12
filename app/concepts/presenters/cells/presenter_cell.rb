module Presenters
  module Cells
    class PresenterCell < Cell::ViewModel
      def featured
        render
      end

      private

      def name
        model.name
      end

      def title
        model.title
      end

      def photo_url
        model.photo_url
      end

      def twitter_url
        "http://twitter.com/#{model.twitter}"
      end

      def github_url
        "http://github.com/#{model.github}"
      end
    end
  end
end
