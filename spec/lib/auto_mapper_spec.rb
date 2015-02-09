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

    it "replaces model attribute values with matching form attributes" do
      expect(subject.to_model).to have_attributes(
        :name => form.name,
        :age  => form.age
      )
    end
  end

  describe "#to_form" do
    it "returns the form passed in the constructor" do
      expect(subject.to_form).to eq(form)
    end

    it "replaces form attribute values with matching model attributes" do
      expect(subject.to_form).to have_attributes(
        :name => model.name,
        :age  => model.age
      )
    end
  end
end
