require "rails_helper"

RSpec.describe Presenters::Create do
  let(:listener)  { spy }
  let(:presenter) { Presenter.first }
  let(:form)      { Presenters::Form.build_from(:presenter, params) }
  let(:params) do
    {
      :presenter => { :name => name }
    }
  end

  subject { Presenters::Create.new(form) }

  before { subject.subscribe(listener) }

  context "with valid form" do
    let(:name) { "Andy" }

    it "creates a new presenter" do
      expect { subject.call }.to change(Presenter, :count).by(1)
    end

    describe "it also" do
      before { subject.call }

      it "sets the presenter's attributes" do
        expect(presenter).to have_attributes(
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

    it "doesn't create a new presenter" do
      expect { subject.call }.not_to change(Presenter, :count)
    end
  end
end
