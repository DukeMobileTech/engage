class SectionParticipantsController < ApplicationController
  before_action :set_site
  before_action :set_section

  # GET /section_participants or /section_participants.json
  def index
    @section_participants = @section.section_participants
  end

  # GET /section_participants/1 or /section_participants/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = @site.sections.find(params.expect(:section_id))
    end

    def set_site
      @site = Site.find(params.expect(:site_id))
    end
end
