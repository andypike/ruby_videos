module PageObjects
  class ShowVideoPage < PageObject
    def open(video)
      visit video_path(video)
    end
  end
end

module PageObjectHelpers
  let(:show_video_page) { PageObjects::ShowVideoPage.new(self) }
end
