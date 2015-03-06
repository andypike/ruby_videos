require "rails_helper"

RSpec.describe Videos::CreateSuggestion, :async => true do
  let(:listener) { double.as_null_object }
  let(:video)    { Video.first }
  let(:form)     { Videos::SuggestionForm.build_from(:suggestion, params) }
  let(:user)     { create(:user) }
  let(:params) do
    {
      :suggestion => {
        :title => title,
        :url   => "http://something.com/hello"
      }
    }
  end

  subject { Videos::CreateSuggestion.new(form, user) }

  before { subject.subscribe(listener) }

  context "with valid form" do
    let(:title) { "All the little things" }
    let(:notification_email) { email_with_subject("suggestion") }

    it "creates a new video" do
      expect { subject.call }.to change(Video, :count).by(1)
    end

    describe "it also" do
      before { subject.call }

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
