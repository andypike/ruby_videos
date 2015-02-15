require_relative "video_form"

module PageObjects
  class AddVideoPage < PageObjectWithForm
    include VideoForm

    def open
      visit new_video_path
    end
  end
end

module PageObjectHelpers
  let(:add_video_page) { PageObjects::AddVideoPage.new(self) }
end
