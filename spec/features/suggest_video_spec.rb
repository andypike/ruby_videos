require "rails_helper"

RSpec.describe "Suggesting a video", :job => true do
  before do
    home_page.open
    main_menu.login_as(user)
    home_page.suggestion_link.click
  end

  context "as a visitor" do
    let(:user) { :visitor }

    context "valid information" do
      it "creates a suggested video" do
        suggestion_page.fill_in_form

        expect { suggestion_page.submit_form }.to change(Video, :count).by(1)
        expect(page).to have_content(/thank you for your suggestion/i)
      end
    end

    context "invalid information" do
      it "show's error messages" do
        suggestion_page.fill_in_form(:title => "")
        suggestion_page.submit_form

        expect(page).to have_content(/can't be blank/i)
      end
    end
  end

  context "as a guest" do
    let(:user) { :guest }

    it "informs the user that they need to be logged in first" do
      expect(page).to have_content(/you need to login/i)
    end

    it "doesn't show the suggestion form" do
      expect(page).not_to have_css("form")
    end
  end
end
