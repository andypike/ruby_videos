require "rails_helper"

RSpec.describe Video do
  describe "#ordered" do
    it "returns videos order by most resent first" do
      create(:video, :title => "a")
      create(:video, :title => "b")
      create(:video, :title => "c")

      expect(described_class.ordered.map(&:title)).to eq(%w(c b a))
    end
  end

  describe "#latest" do
    subject { described_class.latest(3) }

    context "more videos exist than maximum specified" do
      it "returns maximum number of videos" do
        create_list(:video, 5)

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
        create_list(:video, 2)

        expect(subject).to have(2).items
      end
    end

    it "returns videos order by most resent first" do
      create(:video, :title => "a")
      create(:video, :title => "b")
      create(:video, :title => "c")

      expect(subject.map(&:title)).to eq(%w(c b a))
    end
  end
end
