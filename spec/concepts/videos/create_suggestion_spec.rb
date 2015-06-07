require "rails_helper"

RSpec.describe Videos::CreateSuggestion, :async => true do
  let(:video) { Video.first }
  let(:form)  { Videos::SuggestionForm.build_from(:suggestion, params, :user => user) }
  let(:user)  { create(:user) }
  let(:params) do
    {
      :suggestion => {
        :title => title,
        :url   => "http://something.com/hello"
      }
    }
  end

  let(:ok)   { Nala::BlockSpy.new }
  let(:fail) { Nala::BlockSpy.new }

  subject do
    Videos::CreateSuggestion.call(form)
      .on(:ok, &ok.spy)
      .on(:fail, &fail.spy)
  end

  context "with valid form" do
    let(:title) { "All the little things" }
    let(:notification_email) { email_with_subject("suggestion") }

    it "creates a new video" do
      expect { subject }.to change(Video, :count).by(1)
    end

    describe "it also" do
      before { subject }

      it "sets the video's attributes from the form" do
        expect(video).to have_attributes(
          :title => "All the little things",
          :url   => "http://something.com/hello"
        )
      end

      it "sets the video as a draft" do
        expect(video).to be_draft
      end

      it "sets the video as a suggestion" do
        expect(video).to be_suggestion
      end

      it "stores the user that made the suggestion" do
        expect(video.user).to eq(user)
      end

      it "sends an email notification" do
        expect(notification_email).to be_present
        expect(notification_email.to).to include("suggestions@example.com")
        expect(notification_email.body).to include(edit_video_url(video))
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
