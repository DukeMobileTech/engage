class SectionParticipantsController < ApplicationController
  before_action :set_site
  before_action :set_section
  before_action :set_participants, only: %i[ new edit ]
  before_action :set_section_participant, only: %i[ show edit update destroy ]

  # GET /section_participants or /section_participants.json
  def index
    @section_participants = @section.section_participants
  end

  # GET /section_participants/1 or /section_participants/1.json
  def show
  end

  # GET /section_participants/new
  def new
    @section_participant = @section.section_participants.new
  end

  # GET /section_participants/1/edit
  def edit
  end

  # POST /section_participants or /section_participants.json
  def create
    participant_ids = params[:section_participant][:participant_id].reject(&:empty?)
    participant_ids.each do |participant_id|
      @section_participant = @section.section_participants.create(participant_id: participant_id)
    end

    respond_to do |format|
      if @section_participant
        format.html { redirect_to site_section_section_participants_path(@site, @section), notice: "Section participants were successfully enrolled." }
        format.json { render :show, status: :created, location: @section_participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_participants/1 or /section_participants/1.json
  def update
    respond_to do |format|
      if @section_participant.update(section_participant_params)
        format.html { redirect_to @section_participant, notice: "Section participant was successfully updated." }
        format.json { render :show, status: :ok, location: @section_participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_participants/1 or /section_participants/1.json
  def destroy
    @section_participant.destroy!

    respond_to do |format|
      format.html { redirect_to section_participants_path, status: :see_other, notice: "Section participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_participant
      @section_participant = @section.section_participants.find(params.expect(:id))
    end

    def set_section
      @section = @site.sections.find(params.expect(:section_id))
    end

    def set_site
      @site = Site.find(params.expect(:site_id))
    end

    def set_participants
      @participants = @site.participants
      participant_ids = @section.section_participants.pluck(:participant_id)
      @participants = @participants.reject { |participant| participant_ids.include?(participant.id) }
    end

    # Only allow a list of trusted parameters through.
    def section_participant_params
      params.expect(section_participant: [ :section_id, :participant_id ])
    end
end
