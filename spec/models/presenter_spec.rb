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

  describe ".random_published" do
    subject { described_class.random_published(3) }

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

    context "a presenter has multiple published videos" do
      it "returns them only once" do
        presenter = create(:presenter)
        create_list(:published_video, 2, :presenter => presenter)

        expect(subject).to have(1).items
      end
    end
  end

  describe ".list_for" do
    let!(:published) { create(:presenter_with_published_video) }
    let!(:draft)     { create(:presenter_with_draft_video) }

    subject { described_class.list_for(user) }

    context "an admin" do
      let(:user) { build(:admin) }

      it "returns all presenters" do
        expect(subject).to have(2).items
      end
    end

    context "a viewer" do
      let(:user) { build(:viewer) }

      it "returns presenters with published videos" do
        expect(subject).to eq([published])
      end
    end

    context "a guest" do
      let(:user) { GuestUser.new }

      it "returns presenters with published videos" do
        expect(subject).to eq([published])
      end
    end
  end

  describe "#published_videos" do
    it "returns only published videos by the presenter" do
      draft           = build(:draft_video)
      published       = build(:published_video)
      other_published = build(:published_video)

      presenter = create(:presenter, :videos => [draft, published])
      other     = create(:presenter, :videos => [other_published])

      expect(presenter.published_videos).to eq([published])
    end
  end

  describe "#published?" do
    context "has no videos" do
      subject { create(:presenter) }

      it "returns false" do
        expect(subject).not_to be_published
      end
    end

    context "has only published videos" do
      subject { create(:presenter_with_published_video) }

      it "returns true" do
        expect(subject).to be_published
      end
    end

    context "has only draft videos" do
      subject { create(:presenter_with_draft_video) }

      it "returns false" do
        expect(subject).not_to be_published
      end
    end

    context "has both pubished and draft videos" do
      let(:draft)     { create(:draft_video) }
      let(:published) { create(:published_video) }

      subject { create(:presenter, :videos => [draft, published]) }

      it "returns true" do
        expect(subject).to be_published
      end
    end
  end
end
