require "rails_helper"

RSpec.describe Presenters::Form do
  subject { Presenters::Form.new(:name => "Andy") }

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
