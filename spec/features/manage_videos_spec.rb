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

RSpec.describe "Adding a video" do
  before { home_page.open }

  context "as an admin" do
    before do
      create(:presenter)

      main_menu.login_as(:admin)
      home_page.videos_link.click
      videos_page.add_link.click
    end

    context "with valid data" do
      let(:video) { Video.last }

      it "allows videos to be added" do
        add_video_page.fill_in_form

        expect do
          add_video_page.submit_form
        end.to change(Video, :count).by(1)

        expect(page).to have_content(/successfully added video/i)
        expect(page).to have_content("All the little things")
        expect(video).to have_attributes(
          add_video_page.defaults.except(:cover)
        )
        expect(video.cover.url).to include("image.jpg")
      end
    end

    context "with invalid data" do
      it "shows error messages" do
        add_video_page.fill_in_form(:title => "")
        add_video_page.submit_form

        expect(page).to have_content(/can't be blank/i)
      end

      it "populates the form with submitted values" do
        add_video_page.fill_in_form(:title => "x" * 256)
        add_video_page.submit_form

        expect(add_video_page.field(:title)).to eq("x" * 256)
      end
    end
  end

  context "as an visitor" do
    it "hides the add button" do
      main_menu.login_as(:visitor)
      home_page.videos_link.click

      expect(videos_page.add_link).not_to be_present
    end
  end

  context "as an guest" do
    it "hides the add button" do
      home_page.videos_link.click

      expect(videos_page.add_link).not_to be_present
    end
  end

  it_should_behave_like "an admin only page" do
    let(:open) { add_video_page.open }
  end
end
