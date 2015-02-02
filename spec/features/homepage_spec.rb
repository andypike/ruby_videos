require "rails_helper"

RSpec.describe "Homepage" do
  it "shows the site name" do
    home_page.open

    expect(page).to have_content(/ruby videos/i)
  end
end
