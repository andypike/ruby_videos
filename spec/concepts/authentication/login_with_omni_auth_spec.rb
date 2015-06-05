require "rails_helper"

RSpec.describe Authentication::LoginWithOmniAuth do
  let(:user)   { User.first }
  let(:warden) { spy }
  let(:invalid_info) { Authentication::OmniAuthInfo.new }
  let(:valid_info) do
    Authentication::OmniAuthInfo.new(
      :provider => "github",
      :uid      => "12345",
      :info     => {
        :nickname => "andy",
        :name     => "Andy",
        :image    => "http://image.com/12345.png"
      }
    )
  end

  let(:ok)   { Nala::BlockSpy.new }
  let(:fail) { Nala::BlockSpy.new }

  context "with valid info" do
    subject do
      Authentication::LoginWithOmniAuth.call(valid_info, warden)
        .on(:ok, &ok.spy)
        .on(:fail, &fail.spy)
    end

    context "when the user doesn't have an account" do
      it "creates a new user" do
        expect { subject }.to change(User, :count).by(1)
      end

      describe "it also" do
        before { subject }

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
          expect(ok).to be_called_with(user)
        end

        it "logs in the user" do
          expect(warden).to have_received(:login).with(user)
        end

        it "doesn't publish the :fail event" do
          expect(fail).not_to be_called
        end
      end
    end

    context "when the user already has an account" do
      it "doesn't create a new user" do
        create(:user, :uid => "12345", :provider => "github")

        expect { subject }.not_to change(User, :count)
      end

      describe "it also" do
        before { subject }

        it "publishes the :ok event" do
          expect(ok).to be_called_with(user)
        end

        it "logs in the user" do
          expect(warden).to have_received(:login).with(user)
        end
      end
    end
  end

  context "with invalid info" do
    subject do
      Authentication::LoginWithOmniAuth.call(invalid_info, warden)
        .on(:ok, &ok.spy)
        .on(:fail, &fail.spy)
    end

    it "doesn't create a new user" do
      expect { subject }.not_to change(User, :count)
    end

    describe "it also" do
      before { subject }

      it "publishes the :fail event" do
        expect(fail).to be_called
      end

      it "doesn't log in the user" do
        expect(warden).not_to have_received(:login)
      end

      it "doesn't publish the :ok event" do
        expect(ok).not_to be_called
      end
    end
  end
end
