require "rails_helper"

RSpec.describe AutoMapper do
  let(:form)  { FakeForm.new(:name => "Megan", :age => 7) }
  let(:model) { FakeModel.new(:name => "", :age => 0) }

  subject { AutoMapper.new(form) }

  class FakeForm
    include SimpleFormObject

    attribute :name
    attribute :age
  end

  class FakeModel
    include SimpleFormObject

    attribute :name
    attribute :age
  end

  describe "#map_to" do
    it "returns the object passed in" do
      expect(subject.map_to(model)).to eq(model)
    end

    it "replaces attribute values" do
      expect(subject.map_to(model)).to have_attributes(
        :name => form.name,
        :age  => form.age
      )
    end
  end
end
