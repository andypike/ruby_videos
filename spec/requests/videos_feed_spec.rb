require "rails_helper"

RSpec.describe "Videos Feed" do

  let!(:video) do
    create(:published_video,
      :updated_at => DateTime.new(2015, 6, 9))
  end

  before do
    get videos_path, :format => :atom
  end

  let(:feed) { Hash.from_xml(response.body)["feed"] }
  let(:entry) { feed["entry"] }

  it "returns valid atom feed" do
    expect(feed["id"]).to eq(root_url)
    expect(feed["title"]).to eq("Ruby Videos")
    expect(feed["updated"]).to match(/2015-06-09.*00Z/)
  end

  it "returns feed containing valid entry" do
    expect(entry["id"]).to eq(video_url(video))
    expect(entry["title"]).to eq(video.title)
    expect(entry["updated"]).to match(/2015-06-09.*00Z/)
  end

end
