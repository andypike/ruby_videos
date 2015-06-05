require "rails_helper"

RSpec.describe Videos::Update do
  let!(:video) { create(:video, :title => "All the little things") }
  let(:form)   { Videos::Form.build_from(:video, params) }
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

  let(:ok)   { Nala::BlockSpy.new }
  let(:fail) { Nala::BlockSpy.new }

  subject do
    Videos::Update.call(form)
      .on(:ok, &ok.spy)
      .on(:fail, &fail.spy)
  end

  context "with valid form" do
    let(:title) { "Overkill" }

    it "doesn't create a new video" do
      expect { subject }.not_to change(Video, :count)
    end

    describe "it also" do
      before { subject }

      it "sets the video's attributes" do
        expect(video.reload).to have_attributes(
          :title  => "Overkill"
        )
      end

      it "publishes the :ok event" do
        expect(ok).to be_called_with(video)
      end

      it "doesn't publish the :fail event" do
        expect(fail).not_to be_called
      end
    end
  end

  context "with invalid form" do
    let(:title) { "" }

    before { subject }

    it "doesn't sets the video's attributes" do
      expect(video.reload).to have_attributes(
        :title  => "All the little things"
      )
    end

    it "publishes the :fail event" do
      expect(fail).to be_called
    end

    it "doesn't publish the :ok event" do
      expect(ok).not_to be_called
    end
  end
end
