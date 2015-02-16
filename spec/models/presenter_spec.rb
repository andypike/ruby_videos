require "rails_helper"

RSpec.describe Presenter do
  describe ".ordered" do
    it "returns presenters order by name" do
      create(:presenter, :name => "a")
      create(:presenter, :name => "c")
      create(:presenter, :name => "b")

      expect(described_class.ordered.map(&:name)).to eq(%w(a b c))
    end
  end

  describe ".random" do
    subject { described_class.random(3) }

    context "more presenters exist than maximum specified" do
      it "returns maximum number of presenters" do
        create_list(:presenter, 5)

        expect(subject).to have(3).items
      end
    end

    context "no presenters exist" do
      it "returns no presenters" do
        expect(subject).to have(0).items
      end
    end

    context "less presenters exist than maximum specified" do
      it "returns all presenters" do
        create_list(:presenter, 2)

        expect(subject).to have(2).items
      end
    end
  end

  describe "#published_videos" do
    subject { described_class.published_videos }

    it "returns only published videos by the presenter" do
      draft           = build(:draft_video)
      published       = build(:published_video)
      other_published = build(:published_video)

      presenter = create(:presenter, :videos => [draft, published])
      other     = create(:presenter, :videos => [other_published])

      expect(presenter.published_videos).to eq([published])
    end
  end
end
