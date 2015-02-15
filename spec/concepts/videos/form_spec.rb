require "rails_helper"

RSpec.describe Videos::Form do
  subject { described_class.build_from(:video, params) }

  let(:params) do
    {
      :id => 1,
      :video => {
        :title        => "All the little things",
        :description  => "blah",
        :embed_code   => "<embed></embed>",
        :status       => "draft",
        :cover        => "a/file/path.jpg",
        :url          => "http://something.com/hello",
        :presenter_id => Presenter.first.id
      }
    }
  end

  before { create(:presenter) }

  describe "validation" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "#title" do
      it "cannot be blank" do
        subject.title = ""

        expect(subject).not_to be_valid
      end

      it "cannot be over 255 charaters in length" do
        subject.title = "x" * 256

        expect(subject).not_to be_valid
      end
    end

    describe "#description" do
      it "cannot be blank" do
        subject.description = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#embed_code" do
      it "cannot be blank" do
        subject.embed_code = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#status" do
      it "cannot be blank" do
        subject.status = ""

        expect(subject).not_to be_valid
      end

      it "must be a valid status" do
        subject.status = "something"

        expect(subject).not_to be_valid
      end
    end

    describe "#cover" do
      it "cannot be blank" do
        subject.cover = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#url" do
      it "cannot be blank" do
        subject.url = ""

        expect(subject).not_to be_valid
      end

      it "must be a valid url format" do
        subject.url = "something"

        expect(subject).not_to be_valid
      end
    end

    describe "#presenter_id" do
      it "cannot be blank" do
        subject.presenter_id = ""

        expect(subject).not_to be_valid
      end

      it "must be a number" do
        subject.presenter_id = "a"

        expect(subject).not_to be_valid
      end

      it "must match the id of an existing presenter" do
        subject.presenter_id = Presenter.first.id + 1

        expect(subject).not_to be_valid
      end
    end
  end
end
