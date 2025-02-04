class SectionParticipantResponsesController < ApplicationController
  before_action :set_site
  before_action :set_section
  before_action :set_section_participant
  before_action :set_section_participant_response, only: %i[ edit update ]

  # GET /section_participant_responses/new
  def new
    @section_participant_response = SectionParticipantResponse.new(section_participant_id: @section_participant.id)
    @responses = @section_participant.demographics_responses
  end

  # GET /section_participant_responses/1/edit
  def edit
    @responses = @section_participant.demographics_responses
  end

  # POST /section_participant_responses or /section_participant_responses.json
  def create
    @section_participant_response = SectionParticipantResponse.new(section_participant_response_params)

    respond_to do |format|
      if @section_participant_response.save
        format.html { redirect_to site_section_section_participants_path(@site, @section), notice: "Section participant response was successfully created." }
        format.json { render :show, status: :created, location: @section_participant_response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section_participant_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_participant_responses/1 or /section_participant_responses/1.json
  def update
    respond_to do |format|
      if @section_participant_response.update(section_participant_response_params)
        format.html { redirect_to site_section_section_participants_path(@site, @section), notice: "Section participant response was successfully updated." }
        format.json { render :show, status: :ok, location: @section_participant_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section_participant_response.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_participant_response
      @section_participant_response = SectionParticipantResponse.find(params.expect(:id))
    end

    def set_site
      @site = Site.find(params.expect(:site_id))
    end

    def set_section
      @section = @site.sections.find(params.expect(:section_id))
    end

    def set_section_participant
      @section_participant = @section.section_participants.find(params.expect(:section_participant_id))
    end

    # Only allow a list of trusted parameters through.
    def section_participant_response_params
      params.expect(section_participant_response: [ :response_id, :section_participant_id ])
    end
end
