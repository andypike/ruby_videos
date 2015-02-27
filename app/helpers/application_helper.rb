module ApplicationHelper
  def enum_options(klass, attribute)
    klass
      .public_send(attribute.to_s.pluralize)
      .keys
      .map { |k| [k.titleize, k] }
  end

  def markdown(input)
    renderer = Redcarpet::Render::HTML.new(
      :filter_html => true,
      :no_images   => true,
      :no_styles   => true,
      :safe_links_only => true
    )

    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(input).html_safe
  end
end
