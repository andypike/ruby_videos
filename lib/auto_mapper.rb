class AutoMapper
  attr_reader :form, :model

  def initialize(form, model)
    @form  = form
    @model = model
  end

  def to_model
    model.tap do |m|
      form.attributes.each do |attribute, value|
        m.public_send("#{attribute}=", value) if m.respond_to?(attribute)
      end
    end
  end
end
