require "rails_helper"

RSpec.describe Presenters::Create do
  let(:presenter) { Presenter.first }
  let(:form)      { Presenters::Form.build_from(:presenter, params) }
  let(:params) do
    {
      :presenter => { :name => name }
    }
  end

  let(:ok)   { Nala::BlockSpy.new }
  let(:fail) { Nala::BlockSpy.new }

  subject do
    Presenters::Create.call(form)
      .on(:ok, &ok.spy)
      .on(:fail, &fail.spy)
  end

  context "with valid form" do
    let(:name) { "Andy" }

    it "creates a new presenter" do
      expect { subject }.to change(Presenter, :count).by(1)
    end

    describe "it also" do
      before { subject }

      it "sets the presenter's attributes" do
        expect(presenter).to have_attributes(
          :name  => "Andy"
        )
      end

      it "publishes the :ok event" do
        expect(ok).to be_called_with(presenter)
      end

      it "doesn't publish the :fail event" do
        expect(fail).not_to be_called_with
      end
    end
  end

  context "with invalid form" do
    let(:name) { "" }

    it "doesn't create a new presenter" do
      expect { subject }.not_to change(Presenter, :count)
    end

    describe "it also" do
      before { subject }

      it "publishes the :fail event" do
        expect(fail).to be_called
      end

      it "doesn't publish the :ok event" do
        expect(ok).not_to be_called_with
      end
    end
  end
end
