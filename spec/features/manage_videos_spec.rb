require "rails_helper"

RSpec.describe "Listing videos" do
  let!(:published) { create(:published_video, :title => Faker::Lorem.sentence) }
  let!(:draft)     { create(:draft_video, :title => Faker::Lorem.sentence) }

  before { home_page.open }

  context "guest user" do
    it "displays published videos" do
      home_page.videos_link.click

      expect(page).to have_content(published.title)
      expect(page).not_to have_content(draft.title)
    end
  end

  context "viewer user" do
    it "displays published videos" do
      main_menu.login_as(:viewer)
      home_page.videos_link.click

      expect(page).to have_content(published.title)
      expect(page).not_to have_content(draft.title)
    end
  end

  context "admin user" do
    it "displays published videos" do
      main_menu.login_as(:admin)
      home_page.videos_link.click

      expect(page).to have_content(published.title)
      expect(page).to have_content(draft.title)
    end
  end
end
