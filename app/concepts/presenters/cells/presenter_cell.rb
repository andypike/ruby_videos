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

      def show
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

      def twitter_link
        return if model.twitter.blank?

        link_to("Twitter", twitter_url, :class => "btn btn-flat")
      end

      def github_link
        return if model.github.blank?

        link_to("GitHub", github_url, :class => "btn btn-flat")
      end

      def twitter_icon
        return if model.twitter.blank?

        link_to(twitter_url) do
          content_tag(:i, "", :class => "fa fa-twitter team-icon team-t")
        end
      end

      def github_icon
        return if model.github.blank?

        link_to(github_url) do
          content_tag(:i, "", :class => "fa fa-github team-icon team-d")
        end
      end

      def edit_link
        return unless current_user.admin?

        link_to("Edit", edit_presenter_path(model), :class => "btn btn-flat")
      end

      def show_link
        link_to(name, show_path)
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
