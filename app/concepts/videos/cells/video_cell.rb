module Videos
  module Cells
    class VideoCell < Cell::ViewModel
      delegate :current_user, :to => :controller

      def latest
        render
      end

      def list
        render
      end

      private

      property :title
      property :description
      property :cover_url

      def subtitle
        date = model.created_at.strftime("%d %B %Y")

        "By #{model.presenter.name} on #{date}"
      end

      def show_path
        video_path(model)
      end

      def edit_link
        return unless current_user.admin?

        link_to("Edit", edit_video_path(model), :class => "btn btn-flat")
      end

      def status
        return unless current_user.admin?

        content_tag(:div, model.status.titleize, :class => "label label-info")
      end
    end
  end
end
