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

  describe ".with_published_videos" do
    subject { described_class.with_published_videos(3) }

    context "more presenters with published videos exist than max specified" do
      it "returns any n presenters" do
        with_published = create_list(:presenter_with_published_video, 5)
        with_draft = create(:presenter_with_draft_video)
        no_videos  = create(:presenter)

        expect(subject).to have(3).items
        expect(subject - with_published).to be_empty
        expect(subject).not_to include(with_draft)
        expect(subject).not_to include(no_videos)
      end
    end

    context "no presenters exist" do
      it "returns no presenters" do
        expect(subject).to have(0).items
      end
    end

    context "less presenters with published videos exist than max specified" do
      it "returns all presenters with published videos" do
        with_published = create_list(:presenter_with_published_video, 2)
        with_draft = create(:presenter_with_draft_video)
        no_videos  = create(:presenter)

        expect(subject).to have(2).items
        expect(subject).to contain_exactly(*with_published)
        expect(subject).not_to include(with_draft)
        expect(subject).not_to include(no_videos)
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
