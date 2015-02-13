require_relative "presenter_form"

module PageObjects
  class AddPresenterPage < PageObjectWithForm
    include PresenterForm

    def open
      visit new_presenter_path
    end
  end
end

module PageObjectHelpers
  let(:add_presenter_page) { PageObjects::AddPresenterPage.new(self) }
end
