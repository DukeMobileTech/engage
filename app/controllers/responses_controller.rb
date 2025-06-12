class ResponsesController < ApplicationController
  before_action :set_questionnaire, except: :show
  after_action :verify_authorized

  # GET /responses or /responses.json
  def index
    @responses = @questionnaire.responses.kept.order(created_at: :desc)
    @sitting = Sitting.find(params[:sitting_id]) if params[:sitting_id]
    @responses = @responses.where(sitting_id: @sitting.id) if @sitting
    authorize @responses
  end

  # GET /responses/1 or /responses/1.json
  def show
    @questionnaire = Questionnaire.includes(questions: :answers).find(params[:questionnaire_id])
    @response = @questionnaire.responses.find(params[:id])
    authorize @response
  end

  # GET /responses/new
  def new
    @response = @questionnaire.responses.new
    authorize @response
    @participant = Participant.find(params[:participant_id]) if params[:participant_id]
    @sitting = Sitting.find(params[:sitting_id]) if params[:sitting_id]
    @activities = @sitting.activities if @sitting
    @activity_question = @questionnaire.activity_question
    @delivery_modified_question = @questionnaire.delivery_modified_question
    @content_modified_question = @questionnaire.content_modified_question
    @not_delivered_question = @questionnaire.not_delivered_question
    @observers = @sitting.section.site.observers if @sitting
  end

  # POST /responses or /responses.json
  def create
    @response = @questionnaire.responses.new(response_params.except(:section_participant_id, :section_participant_response_id))
    authorize @response
    respond_to do |format|
      if @response.save
        if @response.sitting
          format.html { redirect_to questionnaire_responses_path(@questionnaire, sitting_id: @response.sitting.id), notice: "Response was successfully created." }
        elsif params[:response][:section_participant_response_id].present?
          spr = SectionParticipantResponse.find(params[:response][:section_participant_response_id])
          spr.update(response: @response)
          format.html { redirect_to site_section_section_participants_path(spr.section_participant.section.site, spr.section_participant.section), notice: "Response was successfully created." }
        elsif params[:response][:section_participant_id].present?
          sp = SectionParticipant.find(params[:response][:section_participant_id])
          SectionParticipantResponse.create(response: @response, section_participant: sp)
          format.html { redirect_to site_section_section_participants_path(sp.section.site, sp.section), notice: "Response was successfully created." }
        elsif @response.participant
          format.html { redirect_to @response.participant, notice: "Response was successfully created." }
        else
          format.html { redirect_to [ @questionnaire, @response ], notice: "Response was successfully created." }
          format.json { render :show, status: :created, location: @response }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response = @questionnaire.responses.find(params[:id])
    authorize @response
    @response.discard
    respond_to do |format|
      format.html { redirect_to questionnaire_responses_path(@questionnaire), status: :see_other, notice: "Response was successfully discarded." }
      format.json { head :no_content }
    end
  end

  private
    def set_questionnaire
      @questionnaire = Questionnaire.find(params.expect(:questionnaire_id))
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(:questionnaire_id, :participant_id, :sitting_id, :user_id, :section_participant_id, :section_participant_response_id, answers: {})
    end
end
