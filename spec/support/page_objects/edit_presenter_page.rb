module PageObjects
  class EditPresenterPage < AddPresenterPage
    def open(presenter)
      visit edit_presenter_path(presenter)
    end
  end

  def edit_presenter_page
    EditPresenterPage.new(self)
  end
end
