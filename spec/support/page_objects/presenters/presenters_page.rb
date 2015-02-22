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

    def presenter_link(presenter)
      find_link(presenter.name)
    end
  end
end

module PageObjectHelpers
  let(:presenters_page) { PageObjects::PresentersPage.new(self) }
end
