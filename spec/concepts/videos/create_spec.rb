require "rails_helper"

RSpec.describe Videos::Create do
  let(:listener)  { spy }
  let(:video)     { Video.first }
  let(:form)      { Videos::Form.build_from(:video, params) }
  let(:user)      { create(:user) }
  let(:presenter) { create(:presenter) }
  let(:params) do
    {
      :video => {
        :title        => title,
        :description  => "something",
        :embed_code   => "<div>",
        :status       => "draft",
        :url          => "http://youtube.com/123",
        :presenter_id => presenter.id
      }
    }
  end

  subject { Videos::Create.new(form, user) }

  before { subject.subscribe(listener) }

  context "with valid form" do
    let(:title) { "All the little things" }

    it "creates a new video" do
      expect { subject.call }.to change(Video, :count).by(1)
    end

    describe "it also" do
      before { subject.call }

      it "sets the video's attributes" do
        expect(video).to have_attributes(
          :title => "All the little things"
        )
      end

      it "stores the user that created the video" do
        expect(video.user).to eq(user)
      end

      it "publishes the :ok event" do
        expect(listener).to have_received(:ok).with(video)
      end
    end
  end

  context "with invalid form" do
    let(:title) { "" }

    it "publishes the :fail event" do
      subject.call

      expect(listener).to have_received(:fail)
    end

    it "doesn't create a new video" do
      expect { subject.call }.not_to change(Video, :count)
    end
  end
end
