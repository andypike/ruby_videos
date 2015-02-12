require "rails_helper"

RSpec.describe "Homepage" do
  it "shows the site name" do
    home_page.open

    expect(page).to have_content(/ruby videos/i)
  end

  it "shows any three presenters" do
    create_list(:presenter, 5)

    home_page.open

    expect(home_page.presenters.size).to eq(3)
  end
end
