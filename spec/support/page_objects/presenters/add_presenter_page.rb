require_relative "presenter_form"

module PageObjects
  class AddPresenterPage < PageObjectWithForm
    include PresenterForm

    def open
      visit new_presenter_path
    end
  end

  def add_presenter_page
    AddPresenterPage.new(self)
  end
end
