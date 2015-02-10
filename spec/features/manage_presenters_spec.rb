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

  it_should_behave_like "an admin only page with menu" do
    let(:open) { presenters_page.open }
    let(:menu) { main_menu.presenters_link }
  end
end

RSpec.describe "Adding a presenter" do
  before { home_page.open }

  context "as an admin" do
    before do
      main_menu.login_as(:admin)
      main_menu.presenters_link.click
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
        expect(presenter.photo.url).to include("photo.jpg")
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

        expect(add_presenter_page.field(:name)).to eq("x" * 256)
      end
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
      main_menu.presenters_link.click
      presenters_page.edit_link.click
    end

    context "with valid data" do
      it "populates the form" do
        expect(edit_presenter_page.field(:name)).to eq("Bob Smith")
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

        expect(edit_presenter_page.field(:name)).to eq("x" * 256)
      end
    end
  end

  it_should_behave_like "an admin only page" do
    let(:open) { edit_presenter_page.open(presenter) }
  end
end
