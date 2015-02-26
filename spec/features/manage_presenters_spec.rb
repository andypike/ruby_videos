require "rails_helper"

RSpec.describe "Listing presenters" do
  let!(:published) { create(:presenter_with_published_video) }
  let!(:draft)     { create(:presenter_with_draft_video) }

  before { home_page.open }

  context "guest user" do
    it "displays presenters with published videos" do
      home_page.presenters_link.click

      expect(page).to have_content(published.name)
      expect(page).not_to have_content(draft.name)
    end
  end

  context "viewer user" do
    it "displays presenters with published videos" do
      main_menu.login_as(:viewer)
      home_page.presenters_link.click

      expect(page).to have_content(published.name)
      expect(page).not_to have_content(draft.name)
    end
  end

  context "admin user" do
    it "displays all presenters" do
      main_menu.login_as(:admin)
      home_page.presenters_link.click

      expect(page).to have_content(published.name)
      expect(page).to have_content(draft.name)
    end
  end
end

RSpec.describe "Adding a presenter" do
  before { home_page.open }

  context "as an admin" do
    before do
      main_menu.login_as(:admin)
      home_page.presenters_link.click
      presenters_page.add_link.click
    end

    context "with valid data" do
      let(:presenter) { Presenter.last }

      it "allows presenters to be added" do
        add_presenter_page.fill_in_form

        expect do
          add_presenter_page.submit_form
        end.to change(Presenter, :count).by(1)

        expect(page).to have_content(/successfully added presenter/i)
        expect(page).to have_content("Sandi Metz")
        expect(presenter).to have_attributes(
          add_presenter_page.defaults.except(:photo)
        )
        expect(presenter.photo.url).to include("image.jpg")
      end
    end

    context "with invalid data" do
      it "shows error messages" do
        add_presenter_page.fill_in_form(:name => "")
        add_presenter_page.submit_form

        expect(page).to have_content(/can't be blank/i)
      end

      it "populates the form with submitted values" do
        add_presenter_page.fill_in_form(:name => "x" * 256)
        add_presenter_page.submit_form

        expect(add_presenter_page.field(:name).value).to eq("x" * 256)
      end
    end
  end

  context "as an visitor" do
    it "hides the add button" do
      main_menu.login_as(:visitor)
      home_page.presenters_link.click

      expect(presenters_page.add_link).not_to be_present
    end
  end

  context "as an guest" do
    it "hides the add button" do
      home_page.presenters_link.click

      expect(presenters_page.add_link).not_to be_present
    end
  end

  it_should_behave_like "an admin only page" do
    let(:open) { add_presenter_page.open }
  end
end

RSpec.describe "Edit a presenter" do
  let!(:presenter) { create(:presenter) }

  before { home_page.open }

  context "as an admin" do
    before do
      main_menu.login_as(:admin)
      home_page.presenters_link.click
      presenters_page.edit_link.click
    end

    context "with valid data" do
      it "populates the form" do
        expect(edit_presenter_page.field(:name).value).to eq(presenter.name)
      end

      it "allows the presenter to be updated" do
        edit_presenter_page.fill_in_form(:name => "Edited Name")

        expect do
          edit_presenter_page.submit_form
        end.not_to change(Presenter, :count)

        expect(page).to have_content(/successfully edited presenter/i)
        expect(page).to have_content("Edited Name")
        expect(presenter.reload.name).to eq("Edited Name")
      end
    end

    context "with invalid data" do
      it "shows error messages" do
        edit_presenter_page.fill_in_form(:name => "")
        edit_presenter_page.submit_form

        expect(page).to have_content(/can't be blank/i)
      end

      it "populates the form with submitted values" do
        edit_presenter_page.fill_in_form(:name => "x" * 256)
        edit_presenter_page.submit_form

        expect(edit_presenter_page.field(:name).value).to eq("x" * 256)
      end
    end
  end

  context "as an visitor" do
    it "hides the edit button" do
      main_menu.login_as(:visitor)
      home_page.presenters_link.click

      expect(presenters_page.edit_link).not_to be_present
    end
  end

  context "as an guest" do
    it "hides the edit button" do
      home_page.presenters_link.click

      expect(presenters_page.edit_link).not_to be_present
    end
  end

  it_should_behave_like "an admin only page" do
    let(:open) { edit_presenter_page.open(presenter) }
  end
end

RSpec.describe "View a presenter" do
  let(:published) { create(:published_video) }
  let(:draft)     { create(:draft_video) }

  def expect_page_to_be_seo_friendly
    expect(current_path).not_to include(presenter.id.to_s)
    expect(page).to have_title(/#{presenter.name}/i)
  end

  def expect_page_to_display_presenter
    expect(page).to have_content(presenter.name)
  end

  context "that is published" do
    let!(:presenter) { create(:presenter, :videos => [published, draft]) }

    before do
      home_page.open
      main_menu.login_as(user)
      presenters_page.presenter_link(presenter).click
    end

    context "as an admin" do
      let(:user) { :admin }

      it "shows the presenters page" do
        expect_page_to_be_seo_friendly
        expect_page_to_display_presenter
      end

      it "shows published and draft videos" do
        expect(show_presenter_page.video_link(published)).to be_present
        expect(show_presenter_page.video_link(draft)).to be_present
      end
    end

    context "as a visitor" do
      let(:user) { :visitor }

      it "shows the presenters page" do
        expect_page_to_be_seo_friendly
        expect_page_to_display_presenter
      end

      it "shows published videos" do
        expect(show_presenter_page.video_link(published)).to be_present
      end

      it "does not show draft videos" do
        expect(show_presenter_page.video_link(draft)).not_to be_present
      end
    end

    context "as a guest" do
      let(:user) { :guest }

      it "shows the presenters page" do
        expect_page_to_be_seo_friendly
        expect_page_to_display_presenter
      end

      it "shows published videos" do
        expect(show_presenter_page.video_link(published)).to be_present
      end

      it "does not show draft videos" do
        expect(show_presenter_page.video_link(draft)).not_to be_present
      end
    end
  end

  context "that isn't published" do
    let!(:presenter) { create(:presenter, :videos => [draft]) }

    before { home_page.open }

    context "as an admin" do
      it "shows the presenters page" do
        main_menu.login_as(:admin)
        show_presenter_page.open(presenter)

        expect_page_to_be_seo_friendly
        expect_page_to_display_presenter
        expect(show_presenter_page.video_link(draft)).to be_present
      end
    end

    it_should_behave_like "an admin only page" do
      let(:open) { show_presenter_page.open(presenter) }
    end
  end
end
