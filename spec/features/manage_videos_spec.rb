require "rails_helper"

RSpec.describe "Listing videos" do
  let!(:published) { create(:published_video) }
  let!(:draft)     { create(:draft_video) }

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
    it "displays all videos" do
      main_menu.login_as(:admin)
      home_page.videos_link.click

      expect(page).to have_content(published.title)
      expect(page).to have_content(draft.title)
    end

    it "displays suggestions" do
      suggestion = create(:suggested_video)

      main_menu.login_as(:admin)
      home_page.videos_link.click

      expect(page).to have_content(suggestion.title)
      expect(page).to have_content(/suggestion/i)
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

RSpec.describe "Edit a video" do
  let!(:video) { create(:video) }

  before { home_page.open }

  context "as an admin" do
    before do
      main_menu.login_as(:admin)
      home_page.videos_link.click
      videos_page.edit_link.click
    end

    context "with valid data" do
      it "populates the form" do
        expect(edit_video_page.field(:title)).to eq(video.title)
        expect(edit_video_page.field(:status)).to eq("draft")
      end

      it "allows the video to be updated" do
        edit_video_page.fill_in_form(:title => "Edited Title")

        expect do
          edit_video_page.submit_form
        end.not_to change(Video, :count)

        expect(page).to have_content(/successfully edited video/i)
        expect(page).to have_content("Edited Title")
        expect(video.reload.title).to eq("Edited Title")
      end
    end

    context "with invalid data" do
      it "shows error messages" do
        edit_video_page.fill_in_form(:title => "")
        edit_video_page.submit_form

        expect(page).to have_content(/can't be blank/i)
      end

      it "populates the form with submitted values" do
        edit_video_page.fill_in_form(:title => "x" * 256)
        edit_video_page.submit_form

        expect(edit_video_page.field(:title)).to eq("x" * 256)
      end
    end
  end

  context "as an visitor" do
    it "hides the edit button" do
      main_menu.login_as(:visitor)
      home_page.videos_link.click

      expect(videos_page.edit_link).not_to be_present
    end
  end

  context "as an guest" do
    it "hides the edit button" do
      home_page.videos_link.click

      expect(videos_page.edit_link).not_to be_present
    end
  end

  it_should_behave_like "an admin only page" do
    let(:open) { edit_video_page.open(video) }
  end
end

RSpec.describe "View a video" do
  let(:video) { presenter.videos.first }

  def expect_page_to_be_seo_friendly
    expect(current_path).not_to include(video.id.to_s)
    expect(page).to have_title(/#{video.title} By #{presenter.name}/i)
  end

  def expect_page_to_display_video
    expect(page).to have_content(video.title)
    expect(page.html).to include(video.embed_code)
  end

  context "that is published" do
    let!(:presenter) { create(:presenter_with_published_video) }

    before do
      home_page.open
      main_menu.login_as(user)
      videos_page.open
      videos_page.video_link(video).click
    end

    context "as an admin" do
      let(:user) { :admin }

      it "shows the video on an seo friendly url" do
        expect_page_to_be_seo_friendly
        expect_page_to_display_video
      end
    end

    context "as a viewer" do
      let(:user) { :viewer }

      it "shows the video on an seo friendly url" do
        expect_page_to_be_seo_friendly
        expect_page_to_display_video
      end
    end

    context "as a guest" do
      let(:user) { :guest }

      it "shows the video on an seo friendly url" do
        expect_page_to_be_seo_friendly
        expect_page_to_display_video
      end
    end
  end

  context "that is a draft" do
    let!(:presenter) { create(:presenter_with_draft_video) }

    before { home_page.open }

    context "as an admin" do
      it "shows the video on an seo friendly url" do
        main_menu.login_as(:admin)
        show_video_page.open(video)

        expect_page_to_be_seo_friendly
        expect_page_to_display_video
      end
    end

    it_should_behave_like "an admin only page" do
      let(:open) { show_video_page.open(video) }
    end
  end
end
