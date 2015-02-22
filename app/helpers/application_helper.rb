module ApplicationHelper
  def enum_options(klass, attribute)
    klass
      .public_send(attribute.to_s.pluralize)
      .keys
      .map { |k| [k.titleize, k] }
  end
end
