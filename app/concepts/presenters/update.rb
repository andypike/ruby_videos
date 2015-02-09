module Presenters
  class Update
    include Wisper::Publisher

    attr_reader :form

    def initialize(form)
      @form = form
    end

    def call
      # TODO: Refactor this and the create operation as they are virtually the same
      presenter = Presenter.find(form.id)
      mapper = AutoMapper.new(form, presenter)

      if form.valid?
        presenter = mapper.to_model
        presenter.save
        publish(:ok, presenter)
      else
        publish(:fail)
      end
    end
  end
end
