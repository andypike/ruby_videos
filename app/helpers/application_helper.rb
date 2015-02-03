module ApplicationHelper
  def smooth_link_to(text, anchor)
    href = root_path(:anchor => anchor)
    href = "##{anchor}" if controller_name == "home"

    link_to text, href, :class => "scroll-smooth"
  end
end
