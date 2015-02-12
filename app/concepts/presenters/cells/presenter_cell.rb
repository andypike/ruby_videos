module Presenters
  module Cells
    class PresenterCell < Cell::ViewModel
      def featured
        render
      end

      def list
        render
      end

      private

      def name
        model.name
      end

      def bio
        model.bio
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

      def edit_path
        edit_presenter_path(model)
      end

      def videos
        "99 Videos"
      end

      def current_user
        parent_controller.current_user
      end
    end
  end
end
