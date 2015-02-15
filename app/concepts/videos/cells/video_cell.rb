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
      property :status

      def subtitle
        date = model.created_at.strftime("%d %B %Y")

        "By #{model.presenter.name} on #{date}"
      end

      def show_path
        video_path(model)
      end

      def edit_path
        edit_video_path(model)
      end
    end
  end
end
