class AttendancesController < ApplicationController
  # GET /attendances or /attendances.json
  def index
    @site = Site.find(params.expect(:site_id))
    @section = @site.sections.find(params.expect(:section_id))
    @sitting = @section.sittings.find(params.expect(:sitting_id))
    @attendances = @sitting.attendances
  end
end
