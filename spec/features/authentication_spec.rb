require "rails_helper"

RSpec.describe "Authentication" do
  before { home_page.open }

  describe "Logging in via GitHub" do
    context "with valid OmniAuth hash" do
      before { main_menu.login_as(:visitor) }

      it "shows a success message" do
        expect(page).to have_content(/successfully logged in/i)
      end

      it "shows who is logged in" do
        expect(page).to have_content(/andy pike/i)
      end

      it "hides the login link" do
        expect(main_menu.login_link).not_to be_present
      end
    end

    context "with invalid OmniAuth hash" do
      before { OmniAuth.config.mock_auth[:github] = {} }

      it "shows a failure message" do
        main_menu.login_as(:visitor)

        expect(page).to have_content(/unable to login/i)
      end
    end
  end

  describe "Logging out" do
    it "allows logged in users to logout" do
      main_menu.login_as(:visitor)
      main_menu.logout_link.click

      expect(page).to have_content(/successfully logged out/i)
    end

    it "hides the logout link" do
      expect(main_menu.logout_link).not_to be_present
    end
  end
end
