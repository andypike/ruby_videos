require "rails_helper"

RSpec.describe Presenter do
  describe "#ordered" do
    it "returns presenters order by name" do
      create(:presenter, :name => "a")
      create(:presenter, :name => "c")
      create(:presenter, :name => "b")

      expect(described_class.ordered.map(&:name)).to eq(%w(a b c))
    end
  end
end
