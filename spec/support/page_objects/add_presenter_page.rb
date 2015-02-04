module PageObjects
  class AddPresenterPage < PageObject
    def open
      visit new_presenter_path
    end

    def fill_in_form(fields = {})
      fill_in "Name", :with => fields.fetch(:name) { "Sandi Metz" }
      fill_in "Bio",  :with => "Cyclist, Rubyist, reluctant author (poodr.com)."
      fill_in "Twitter", :with => "sandimetz"
      fill_in "GitHub",  :with => "torqueforge"
      fill_in "Website", :with => "www.sandimetz.com"
      fill_in "Title",   :with => "Author of POODR"
      attach_file "Photo", File.expand_path("spec/support/files/photo.jpg")
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
