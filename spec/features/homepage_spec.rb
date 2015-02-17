require "rails_helper"

RSpec.describe "Homepage" do
  it "shows the site name" do
    home_page.open

    expect(page).to have_content(/ruby videos/i)
  end

  it "shows presenters with published videos" do
    create(:presenter_with_published_video, :name => "Andy")
    create(:presenter_with_published_video, :name => "Mary")
    create(:presenter_with_draft_video, :name => "Amie")
    create(:presenter, :name => "Alex")

    home_page.open

    expect(home_page.presenters.size).to eq(2)
    expect(home_page.presenter("Andy")).to be_present
    expect(home_page.presenter("Mary")).to be_present
    expect(home_page.presenter("Amie")).not_to be_present
    expect(home_page.presenter("Alex")).not_to be_present
  end

  it "shows the latest 9 published videos" do
    create_list(:published_video, 10)

    home_page.open

    expect(home_page.videos.size).to eq(9)
  end
end
