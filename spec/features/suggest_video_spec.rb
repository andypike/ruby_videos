require "rails_helper"

RSpec.describe "Suggesting a video"  do
  it "creates a suggested video" do
    home_page.open
    home_page.suggestion_link.click
    suggestion_page.fill_in_form

    expect { suggestion_page.submit_form }.to change(Video, :count).by(1)
    expect(page).to have_content(/thank you for your suggestion/i)
  end
end
