require "rails_helper"

RSpec.describe Videos::Update do
  let(:listener) { double.as_null_object }
  let(:video)    { create(:video, :title => "All the little things") }
  let(:form)     { Videos::Form.build_from(:video, params) }
  let(:params) do
    {
      :id => video.id,
      :video => {
        :title => title,
        :description  => video.description,
        :embed_code   => video.embed_code,
        :status       => video.status,
        :url          => video.url,
        :presenter_id => video.presenter.id
      }
    }
  end

  subject { Videos::Update.new(form) }

  before { subject.subscribe(listener) }

  context "with valid form" do
    let(:title) { "Overkill" }

    it "doesn't create a new video" do
      expect { subject.call }.not_to change(Video, :count)
    end

    describe "it also" do
      before { subject.call }

      it "sets the video's attributes" do
        expect(video.reload).to have_attributes(
          :title  => "Overkill"
        )
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

    it "doesn't sets the video's attributes" do
      expect(video.reload).to have_attributes(
        :title  => "All the little things"
      )
    end
  end
end
