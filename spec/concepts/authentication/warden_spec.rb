require "rails_helper"

RSpec.describe Authentication::Warden do
  let(:store) { {} }

  subject { Authentication::Warden.new(store) }

  describe "#login" do
    it "adds the user id in the given store" do
      subject.login(User.new(:id => 1))

      expect(store[:user_id]).to eq(1)
    end
  end

  describe "#logout" do
    it "clears out the user id in the given store" do
      subject.logout

      expect(store[:user_id]).to eq(:guest)
    end
  end

  describe "#current_user" do
    context "nobody is logged in" do
      it "returns an unauthenticated user" do
        expect(subject.current_user).not_to be_authenticated
      end
    end

    context "a user is logged in" do
      it "returns the authenticated user" do
        user = create(:user)
        store[:user_id] = user.id

        expect(subject.current_user).to eq(user)
      end
    end
  end
end
