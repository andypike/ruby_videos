module PageObjects
  class HomePage < PageObject
    def open
      visit path
    end

    def path
      root_path
    end

    def presenters
      all(".presenter")
    end

    def presenter(name)
      find(".presenter", :text => name)
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

    def suggestion_link
      find_link("Suggest a Video")
    end
  end
end

module PageObjectHelpers
  let(:home_page) { PageObjects::HomePage.new(self) }
end
