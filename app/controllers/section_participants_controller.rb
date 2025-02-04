class SectionParticipantsController < ApplicationController
  before_action :set_site
  before_action :set_section
  before_action :set_section_participants

  # GET /section_participants or /section_participants.json
  def index
  end

  # GET /section_participants/1 or /section_participants/1.json
  def show
    @section_participant = @section_participants.find(params.expect(:id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params.expect(:site_id))
    end

    def set_section
      @section = @site.sections.find(params.expect(:section_id))
    end

    def set_section_participants
      @section_participants = @section.section_participants
    end
end
