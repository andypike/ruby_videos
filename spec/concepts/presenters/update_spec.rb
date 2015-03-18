require "rails_helper"

RSpec.describe Presenters::Update do
  let(:listener)  { spy }
  let(:presenter) { create(:presenter, :name => "Bob Smith") }
  let(:form)      { Presenters::Form.build_from(:presenter, params) }
  let(:params) do
    {
      :id => presenter.id,
      :presenter => { :name => name }
    }
  end

  subject { Presenters::Update.new(form) }

  before { subject.subscribe(listener) }

  context "with valid form" do
    let(:name) { "Andy" }

    it "doesn't create a new presenter" do
      expect { subject.call }.not_to change(Presenter, :count)
    end

    describe "it also" do
      before { subject.call }

      it "sets the presenter's attributes" do
        expect(presenter.reload).to have_attributes(
          :name  => "Andy"
        )
      end

      it "publishes the :ok event" do
        expect(listener).to have_received(:ok).with(presenter)
      end
    end
  end

  context "with invalid form" do
    let(:name) { "" }

    it "publishes the :fail event" do
      subject.call

      expect(listener).to have_received(:fail)
    end

    it "doesn't sets the presenter's attributes" do
      expect(presenter.reload).to have_attributes(
        :name  => "Bob Smith"
      )
    end
  end
end
