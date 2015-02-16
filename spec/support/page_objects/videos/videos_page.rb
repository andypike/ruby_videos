module PageObjects
  class VideosPage < PageObject
    def open
      visit videos_path
    end

    def add_link
      find_link("Add")
    end

    def edit_link
      find_link("Edit")
    end
  end
end

module PageObjectHelpers
  let(:videos_page) { PageObjects::VideosPage.new(self) }
end
