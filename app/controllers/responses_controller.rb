class ResponsesController < ApplicationController
  before_action :set_questionnaire, except: :show

  # GET /responses or /responses.json
  def index
    @responses = @questionnaire.responses.all
  end

  # GET /responses/1 or /responses/1.json
  def show
    @questionnaire = Questionnaire.includes(questions: :answers).find(params[:questionnaire_id])
    @response = @questionnaire.responses.find(params[:id])
  end

  # GET /responses/new
  def new
    @response = @questionnaire.responses.new
    @participant = Participant.find(params[:participant_id]) if params[:participant_id]
    @sitting = Sitting.find(params[:sitting_id]) if params[:sitting_id]
    @sites = Site.all
  end

  # POST /responses or /responses.json
  def create
    @response = @questionnaire.responses.new(response_params)

    respond_to do |format|
      if @response.save
        if @response.sitting
          format.html { redirect_to questionnaire_responses_path(@questionnaire, sitting_id: @response.sitting.id), notice: "Response was successfully created." }
        elsif @response.participant
          @response.associate_section
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

  private
    def set_questionnaire
      @questionnaire = Questionnaire.find(params.expect(:questionnaire_id))
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(:questionnaire_id, :participant_id, :sitting_id, :user_id, answers: {})
    end
end
