require_relative "presenter_form"

module PageObjects
  class EditPresenterPage < PageObjectWithForm
    include PresenterForm

    def open(presenter)
      visit edit_presenter_path(presenter)
    end
  end
end

module PageObjectHelpers
  let(:edit_presenter_page) { PageObjects::EditPresenterPage.new(self) }
end
