module ApplicationHelper
  def is_nav_active?(*controllers)
    active = controllers.any? { |controller| params[:controller] == controller }
    active ? "active" : ""
  end
end
