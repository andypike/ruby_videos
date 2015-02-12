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
  end

  def home_page
    HomePage.new(self)
  end
end
