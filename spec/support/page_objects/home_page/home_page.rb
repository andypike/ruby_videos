module PageObjects
  class HomePage < PageObject
    def open
      visit context.root_path
    end

    def presenters
      all(".presenter")
    end

    def presenters_link
      find_link("See all presenters")
    end

    def videos
      all(".video")
    end

    def videos_link
      find_link("See all videos")
    end
  end
end

module PageObjectHelpers
  let(:home_page) { PageObjects::HomePage.new(self) }
end
