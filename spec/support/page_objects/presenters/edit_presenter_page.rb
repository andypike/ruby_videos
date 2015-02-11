require_relative "presenter_form"

module PageObjects
  class EditPresenterPage < PageObjectWithForm
    include PresenterForm

    def open(presenter)
      visit edit_presenter_path(presenter)
    end
  end

  def edit_presenter_page
    EditPresenterPage.new(self)
  end
end
