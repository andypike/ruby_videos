module PageObjects
  class PresentersPage < PageObject
    def open
      visit presenters_path
    end
  end

  def presenters_page
    PresentersPage.new(self)
  end
end
