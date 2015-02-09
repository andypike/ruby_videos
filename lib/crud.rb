class CRUD
  include Wisper::Publisher

  attr_reader :form

  def initialize(form)
    @form = form
  end

  def call
    mapper = AutoMapper.new(form, model)

    if form.valid?
      mapper.to_model.save
      publish(:ok, mapper.model)
    else
      publish(:fail)
    end
  end
end
