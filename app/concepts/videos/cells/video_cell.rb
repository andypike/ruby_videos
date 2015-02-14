module Videos
  module Cells
    class VideoCell < Cell::ViewModel
      def latest
        render
      end

      private

      def title
        model.title
      end

      def cover_url
        model.cover_url
      end

      def show_path
        video_path(model)
      end
    end
  end
end
