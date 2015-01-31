module PageObjects
  class HomePage < PageObject
    def open
      visit context.root_path
    end
  end

  def home_page
    HomePage.new(self)
  end
end
