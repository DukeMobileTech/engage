class AttendancesController < ApplicationController
  # GET /attendances or /attendances.json
  def index
    @site = Site.find(params.expect(:site_id))
    @section = @site.sections.find(params.expect(:section_id))
    @session = @section.sessions.find(params.expect(:session_id))
    @attendances = @session.attendances
  end
end
