class CRUD
  include Nala::Publisher

  attr_reader :form

  def initialize(form)
    @form = form
  end

  def call
    if form.valid?
      AutoMapper.new(form).map_to(model).tap do |m|
        m.save!
        publish(:ok, m)
      end
    else
      publish(:fail)
    end
  end
end
