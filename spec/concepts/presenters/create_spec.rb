require "rails_helper"

RSpec.describe Presenters::Create do
  let(:listener)     { double.as_null_object }
  let(:presenter)    { Presenter.first }
  let(:valid_form)   { Presenters::Form.new(:name => "Andy") }
  let(:invalid_form) { Presenters::Form.new(:name => "") }

  before { subject.subscribe(listener) }

  context "with valid form" do
    subject { Presenters::Create.new(valid_form) }

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
    subject { Presenters::Create.new(invalid_form) }

    it "publishes the :fail event" do
      subject.call

      expect(listener).to have_received(:fail)
    end

    it "doesn't create a new presenter" do
      expect { subject.call }.not_to change(Presenter, :count)
    end
  end
end
