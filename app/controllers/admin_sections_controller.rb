class AdminSectionsController < ApplicationController
  after_action :verify_authorized

  def index
    @query = Section.kept.ransack(params[:query])
    @sections = @query.result(distinct: true).order("name ASC")
    # Categorize filtered sections
    today = Date.today
    @needs_attention = @sections.select { |s| s.end_date < today && !s.completed? }.sort_by(&:end_date).reverse
    @currently_implementing = @sections.select { |s| s.start_date <= today && s.end_date >= today }
    @previously_implemented = @sections.select { |s| s.end_date < today && s.completed? }.sort_by(&:end_date).reverse
    @yet_to_start = @sections.select { |s| s.start_date > today }
    # Headless policy authorization
    authorize :admin_section, :index?
  end
end
