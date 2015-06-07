require "rails_helper"

RSpec.describe Videos::CreateForm do
  subject { described_class.build_from(:video, params, :user => user) }

  let(:user) { build(:user) }
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

  describe "mapping values" do
    it "assigns the user" do
      expect(subject.user).to eq(user)
    end
  end

  describe "validation" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "#user" do
      it "cannot be blank" do
        subject.user = nil

        expect(subject).not_to be_valid
      end
    end
  end
end
