require "rails_helper"

RSpec.describe AutoMapper do
  let(:form)  { FakeForm.new(:name => "Megan", :age => 7) }
  let(:model) { FakeModel.new(:name => "", :age => 0) }

  subject { AutoMapper.new(form, model) }

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

  describe "#to_model" do
    it "returns the model passed in the constructor" do
      expect(subject.to_model).to eq(model)
    end

    it "maps attributes with matching names overwriting current values" do
      expect(subject.to_model).to have_attributes(
        :name => form.name,
        :age  => form.age
      )
    end
  end
end
