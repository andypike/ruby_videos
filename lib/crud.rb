class CRUD
  include Wisper::Publisher

  attr_reader :form, :user

  def initialize(form, user = :anonymous)
    @form = form
    @user = user
  end

  def call
    if form.valid?
      AutoMapper.new(form).map_to(model).tap do |m|
        m.user = user unless user == :anonymous
        m.save
        publish(:ok, m)
      end
    else
      publish(:fail)
    end
  end
end
