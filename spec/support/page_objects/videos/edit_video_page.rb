require_relative "video_form"

module PageObjects
  class EditVideoPage < PageObjectWithForm
    include VideoForm

    def open(video)
      visit edit_video_path(video)
    end
  end
end

module PageObjectHelpers
  let(:edit_video_page) { PageObjects::EditVideoPage.new(self) }
end
