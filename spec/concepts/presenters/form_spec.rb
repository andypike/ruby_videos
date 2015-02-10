require "rails_helper"

RSpec.describe Presenters::Form do
  subject { described_class.build_from(:presenter, params) }
  let(:params) do
    {
      :id => 1,
      :presenter => { :name => "Andy" }
    }
  end

  describe ".build_from" do
    it "returns an instance of Presenters::Form" do
      expect(subject).to be_a(Presenters::Form)
    end

    context "when the params contains an :id" do
      it "populates the forms id attribute" do
        expect(subject.id).to eq(1)
      end
    end

    context "when the params doesn't contains an :id" do
      it "doesn't populates the forms id attribute" do
        params.delete(:id)
        expect(subject.id).to be_blank
      end
    end

    it "populates attributes from the passed hash" do
      expect(subject).to have_attributes(
        :name => "Andy"
      )
    end
  end

  describe "validation" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "#name" do
      it "cannot be blank" do
        subject.name = ""

        expect(subject).not_to be_valid
      end

      it "cannot be over 255 charaters in length" do
        subject.name = "x" * 256

        expect(subject).not_to be_valid
      end
    end
  end
end
