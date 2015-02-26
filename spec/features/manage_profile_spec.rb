require "rails_helper"

RSpec.describe "Managing a user's profile" do
  context "as a visitor" do
    let(:user) { User.first }

    before do
      home_page.open
      main_menu.login_as(:visitor)

      user.update(:opted_into_newsletters => true)

      main_menu.profile_link.click
    end

    it "shows the correct page" do
      expect(page).to have_content(/Your profile/i)
    end

    describe "updating a profile" do
      it "populates the form correctly" do
        expect(profile_page.field(:opted_into_newsletters)).to be_checked
      end

      it "saves changes" do
        profile_page.fill_in_form
        profile_page.submit_form

        expect(page).to have_content(/updated your profile/i)
        expect(user.reload).not_to be_opted_into_newsletters
      end
    end
  end

  context "as a guest" do
    let(:open) { profile_page.open }
    let(:menu) { main_menu.profile_link }

    it_should_behave_like "a page with a hidden menu"
    it_should_behave_like "a protected page"
  end
end
