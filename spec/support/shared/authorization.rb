RSpec.shared_examples_for "a protected page" do
  it "disallows direct access" do
    open

    expect(current_page.accessed_denied_message).to be_present
  end
end

RSpec.shared_examples_for "a page with a hidden menu" do
  it "hides the menu option" do
    expect(menu).not_to be_present
  end
end

RSpec.shared_examples_for "an admin only page" do
  context "as a viewer" do
    before { main_menu.login_as(:viewer) }

    it_should_behave_like "a protected page"
  end

  context "as a guest" do
    it_should_behave_like "a protected page"
  end
end

RSpec.shared_examples_for "an admin only page with menu" do
  context "as a viewer" do
    before { main_menu.login_as(:viewer) }

    it_should_behave_like "a protected page"
    it_should_behave_like "a page with a hidden menu"
  end

  context "as a guest" do
    it_should_behave_like "a protected page"
    it_should_behave_like "a page with a hidden menu"
  end
end
