require "rails_helper"

RSpec.describe Authentication::OmniAuthInfo do
  let(:omni_auth_hash) do
    {
      :provider => "github",
      :uid      => "12345",
      :info => {
        :nickname => "andypike",
        :name     => "Andy Pike",
        :image    => "https://avatars.githubusercontent.com/u/117697?v=3"
      }
    }
  end

  describe "population" do
    context "from valid OmniAuth hash" do
      it "populates attributes" do
        info = Authentication::OmniAuthInfo.new(omni_auth_hash)

        expect(info).to have_attributes(
          :provider  => "github",
          :uid       => "12345",
          :nickname  => "andypike",
          :name      => "Andy Pike",
          :image_url => "https://avatars.githubusercontent.com/u/117697?v=3"
        )
      end
    end

    context "from empty hash" do
      it "uses default values" do
        info = Authentication::OmniAuthInfo.new

        expect(info).to have_attributes(
          :provider  => "",
          :uid       => "",
          :nickname  => "",
          :name      => "",
          :image_url => ""
        )
      end
    end

    context "passed nil" do
      it "raises a useful error" do
        expect do
          Authentication::OmniAuthInfo.new(nil)
        end.to raise_error(/nil omniauth hash passed/i)
      end
    end
  end

  describe "validation" do
    subject { Authentication::OmniAuthInfo.new(omni_auth_hash) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "#provider" do
      it "cannot be blank" do
        subject.provider = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#uid" do
      it "cannot be blank" do
        subject.uid = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#nickname" do
      it "cannot be blank" do
        subject.nickname = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#name" do
      it "cannot be blank" do
        subject.name = ""

        expect(subject).not_to be_valid
      end
    end

    describe "#image_url" do
      it "cannot be blank" do
        subject.image_url = ""

        expect(subject).not_to be_valid
      end
    end
  end
end
