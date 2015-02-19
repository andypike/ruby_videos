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

      def edit_link
        return unless current_user.admin?

        link_to("Edit", edit_presenter_path(model), :class => "btn btn-flat")
      end

      def show_link
        link_to name, show_path
      end

      def show_path
        presenter_path(model)
      end

      def videos
        pluralize(model.published_videos.size, "Video")
      end
    end
  end
end
