require "rails_helper"

RSpec.describe Video do
  describe "#ordered" do
    it "returns videos order by most resent first" do
      create(:published_video, :title => "a")
      create(:published_video, :title => "b")
      create(:published_video, :title => "c")

      expect(described_class.ordered.map(&:title)).to eq(%w(c b a))
    end
  end

  describe "#latest" do
    subject { described_class.latest(3) }

    it "returns videos order by most resent first" do
      create(:published_video, :title => "a")
      create(:published_video, :title => "b")
      create(:published_video, :title => "c")

      expect(subject.map(&:title)).to eq(%w(c b a))
    end

    it "only returns published videos" do
      create(:draft_video)
      published_video = create(:published_video)

      expect(subject).to have(1).item
      expect(subject).to eq([published_video])
    end

    context "more videos exist than maximum specified" do
      it "returns maximum number of videos" do
        create_list(:published_video, 5)

        expect(subject).to have(3).items
      end
    end

    context "no videos exist" do
      it "returns no videos" do
        expect(subject).to have(0).items
      end
    end

    context "less videos exist than maximum specified" do
      it "returns all videos" do
        create_list(:published_video, 2)

        expect(subject).to have(2).items
      end
    end
  end

  describe "#list_for" do
    let!(:published) { create(:published_video) }
    let!(:draft)     { create(:draft_video) }

    subject { described_class.list_for(user) }

    context "an admin" do
      let(:user) { build(:admin) }

      it "returns all videos" do
        expect(subject).to have(2).items
      end
    end

    context "a viewer" do
      let(:user) { build(:viewer) }

      it "returns published videos" do
        expect(subject).to eq([published])
      end
    end

    context "a guest" do
      let(:user) { GuestUser.new }

      it "returns published videos" do
        expect(subject).to eq([published])
      end
    end
  end
end
