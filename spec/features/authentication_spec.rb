require "rails_helper"

RSpec.describe "Authentication" do
  before { visit root_path }

  describe "Logging in via GitHub" do
    context "with valid OmniAuth hash" do
      it "shows a success message" do
        click_on "Login with GitHub"

        expect(page).to have_content(/successfully logged in/i)
      end

      it "shows who is logged in" do
        click_on "Login with GitHub"

        expect(page).to have_content(/andy pike/i)
      end

      it "hides the login link" do
        click_on "Login with GitHub"

        expect(page).not_to have_link("Login with GitHub")
      end
    end

    context "with invalid OmniAuth hash" do
      before { OmniAuth.config.mock_auth[:github] = {} }

      it "shows a failure message" do
        click_on "Login with GitHub"

        expect(page).to have_content(/unable to login/i)
      end
    end
  end

  describe "Logging out" do
    it "allows logged in users to logout" do
      click_on "Login with GitHub"
      click_on "Logout"

      expect(page).to have_content(/successfully logged out/i)
    end

    it "hides the logout link" do
      expect(page).not_to have_link("Logout")
    end
  end
end
