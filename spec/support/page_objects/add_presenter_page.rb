module PageObjects
  class AddPresenterPage < PageObject
    def open
      visit new_presenter_path
    end

    def fill_in_form(fields = {})
      fill_in "Name", :with => fields.fetch(:name) { "Sandi Metz" }
    end

    def name_field
      find_field("Name").value
    end

    def submit_button
      find_button("Save")
    end
  end

  def add_presenter_page
    AddPresenterPage.new(self)
  end
end
