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

RSpec.describe "Adding a presenter" do
  before { home_page.open }

  context "as an admin" do
    context "with valid data" do
      it "allows presenters to be added" do # TODO: Refactor these specs to remove duplication
        main_menu.login_as(:admin)
        main_menu.presenters_link.click
        presenters_page.add_link.click
        add_presenter_page.fill_in_form

        expect do
          add_presenter_page.submit_button.click
        end.to change(Presenter, :count).by(1)

        expect(page).to have_content(/successfully added presenter/i)
        expect(page).to have_content("Sandi Metz")
      end
    end

    context "with invalid data" do
      it "shows error messages" do
        main_menu.login_as(:admin)
        main_menu.presenters_link.click
        presenters_page.add_link.click
        add_presenter_page.fill_in_form(:name => "")

        add_presenter_page.submit_button.click

        expect(page).to have_content(/can't be blank/i)
      end

      it "populates the form with submitted values" do
        main_menu.login_as(:admin)
        main_menu.presenters_link.click
        presenters_page.add_link.click
        add_presenter_page.fill_in_form(:name => "x" * 256)

        add_presenter_page.submit_button.click

        expect(add_presenter_page.name_field).to eq("x" * 256)
      end
    end
  end

  context "as a viewer" do
    before { main_menu.login_as(:viewer) }

    it "disallows direct access" do
      add_presenter_page.open

      expect(current_page.accessed_denied_message).to be_present
    end
  end

  context "as a guest" do
    it "disallows direct access" do
      add_presenter_page.open

      expect(current_page.accessed_denied_message).to be_present
    end
  end
end
