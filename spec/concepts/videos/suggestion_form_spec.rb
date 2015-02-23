require "rails_helper"

RSpec.describe Videos::SuggestionForm do
  subject { described_class.build_from(:suggestion, params) }

  let(:params) do
    {
      :suggestion => {
        :title => "All the little things",
        :url   => "http://something.com/hello"
      }
    }
  end

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

    describe "#url" do
      it "cannot be blank" do
        subject.url = ""

        expect(subject).not_to be_valid
      end

      it "must be a valid url format" do
        subject.url = "something"

        expect(subject).not_to be_valid
      end

      it "cannot be over 255 charaters in length" do
        subject.url = "http://#{'x' * 245}.com"

        expect(subject).not_to be_valid
      end
    end
  end
end
