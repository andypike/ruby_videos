require "rails_helper"

RSpec.describe Authentication::LoginWithOmniAuth do
  let(:listener) { spy }
  let(:valid_info) do
    instance_double("Authentication::OmniAuthInfo",
      :provider  => "github",
      :uid       => "12345",
      :nickname  => "andy",
      :name      => "Andy",
      :image_url => "http://image.com/12345.png",
      :valid?    => true
    )
  end
  let(:invalid_info) do
    instance_double("Authentication::OmniAuthInfo",
      :valid? => false
    )
  end
  let(:user) { User.first }

  before  { subject.subscribe(listener) }

  context "with valid info" do
    subject { Authentication::LoginWithOmniAuth.new(valid_info) }

    context "when the user doesn't have an account" do
      it "creates a new user" do
        expect { subject.call }.to change(User, :count).by(1)
      end

      describe "it also" do
        before { subject.call }

        it "sets the user as a viewer" do
          expect(user).to be_viewer
        end

        it "sets the user's attributes" do
          expect(user).to have_attributes(
            :provider  => "github",
            :uid       => "12345",
            :nickname  => "andy",
            :name      => "Andy",
            :image_url => "http://image.com/12345.png"
          )
        end

        it "publishes the :ok event" do
          expect(listener).to have_received(:ok).with(user)
        end
      end
    end

    context "when the user already has an account" do
      it "doesn't create a new user" do
        create(:user, :uid => "12345", :provider => "github")

        expect { subject.call }.not_to change(User, :count)
      end

      it "publishes the :ok event" do
        subject.call

        expect(listener).to have_received(:ok).with(user)
      end
    end
  end

  context "with invalid info" do
    subject { Authentication::LoginWithOmniAuth.new(invalid_info) }

    it "publishes the :fail event" do
      subject.call

      expect(listener).to have_received(:fail)
    end

    it "doesn't create a new user" do
      expect { subject.call }.not_to change(User, :count)
    end
  end
end
