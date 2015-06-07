require "rails_helper"

RSpec.describe Videos::Create do
  let(:video)     { Video.first }
  let(:form)      { Videos::CreateForm.build_from(:video, params, :user => user) }
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

  let(:ok)   { Nala::BlockSpy.new }
  let(:fail) { Nala::BlockSpy.new }

  subject do
    Videos::Create.call(form)
      .on(:ok, &ok.spy)
      .on(:fail, &fail.spy)
  end

  context "with valid form" do
    let(:title) { "All the little things" }

    it "creates a new video" do
      expect { subject }.to change(Video, :count).by(1)
    end

    describe "it also" do
      before { subject }

      it "sets the video's attributes" do
        expect(video).to have_attributes(
          :title       => "All the little things",
          :description => "something"
        )
      end

      it "stores the user that created the video" do
        expect(video.user).to eq(user)
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

    it "doesn't create a new video" do
      expect { subject }.not_to change(Video, :count)
    end

    describe "it also" do
      before { subject }

      it "publishes the :fail event" do
        expect(fail).to be_called
      end

      it "doesn't publish the :ok event" do
        expect(ok).not_to be_called
      end
    end
  end
end
