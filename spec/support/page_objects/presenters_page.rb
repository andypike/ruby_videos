module PageObjects
  class PresentersPage < PageObject
    def open
      visit presenters_path
    end

    def add_link
      find_link("Add")
    end

    def edit_link
      find_link("Edit")
    end
  end

  def presenters_page
    PresentersPage.new(self)
  end
end
