module Videos
  module Cells
    class VideoCell < Cell::ViewModel
      include ApplicationHelper

      delegate :current_user, :to => :controller

      def latest
        render
      end

      def list
        render
      end

      def show
        render
      end

      private

      property :title
      property :cover_url
      property :embed_code
      property :presenter_name

      def description
        markdown(model.description)
      end

      def subtitle
        return if model.presenter.blank?

        link_to model.presenter.name, presenter_path(model.presenter)
      end

      def show_link
        link_to title, show_path
      end

      def show_path
        video_path(model.to_param)
      end

      def edit_link
        return unless current_user.admin?

        link_to("Edit", edit_video_path(model), :class => "btn btn-flat")
      end

      def original_link
        link_to("Original Video", model.url, :target => "_blank")
      end

      def status
        return unless current_user.admin?

        content_tag(:div, model.status.titleize, :class => "label label-info")
      end

      def suggestion
        return unless current_user.admin?
        return unless model.suggestion?

        content_tag(:div, "Suggestion", :class => "label label-warning")
      end
    end
  end
end
