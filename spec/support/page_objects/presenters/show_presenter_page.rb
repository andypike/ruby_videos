module PageObjects
  class ShowPresenterPage < PageObject
    def open(presenter)
      visit presenter_path(presenter)
    end

    def video_link(video)
      find_link(video.title)
    end
  end
end

module PageObjectHelpers
  let(:show_presenter_page) { PageObjects::ShowPresenterPage.new(self) }
end
