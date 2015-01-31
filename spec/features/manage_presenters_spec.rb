require "rails_helper"

RSpec.describe "Listing presenters" do
  before { home_page.open }

  context "as an admin" do
    it "displays presenters" do
      presenter = create(:presenter)

      main_menu.login_as(:admin)
      main_menu.presenters_link.click

      expect(page).to have_content(presenter.name)
    end
  end

  context "as a viewer" do
    before { main_menu.login_as(:viewer) }

    it "hides the menu option" do
      expect(main_menu.presenters_link).not_to be_present
    end

    it "disallows direct access" do
      presenters_page.open

      expect(current_page.accessed_denied_message).to be_present
    end
  end

  context "as a guest" do
    it "hides the menu option" do
      expect(main_menu.presenters_link).not_to be_present
    end

    it "disallows direct access" do
      presenters_page.open

      expect(current_page.accessed_denied_message).to be_present
    end
  end
end
