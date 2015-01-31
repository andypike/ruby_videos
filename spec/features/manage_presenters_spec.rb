require "rails_helper"

RSpec.describe "Listing presenters" do
  before { visit root_path }

  context "as an admin" do
    it "displays presenters" do
      presenter = create(:presenter)

      create(:admin)
      click_on "Login with GitHub"
      click_on "Presenters"

      expect(page).to have_content(presenter.name)
    end
  end

  context "as a viewer" do
    before { click_on "Login with GitHub" }

    it "hides the menu option" do
      expect(page).not_to have_link("Presenters")
    end

    it "disallows direct access" do
      visit presenters_path

      expect(page).to have_content(/not authorised/i)
    end
  end

  context "as a guest" do
    it "hides the menu option" do
      expect(page).not_to have_link("Presenters")
    end

    it "disallows direct access" do
      visit presenters_path

      expect(page).to have_content(/not authorised/i)
    end
  end
end
