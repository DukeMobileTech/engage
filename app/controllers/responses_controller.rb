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
  end

  # POST /responses or /responses.json
  def create
    @response = @questionnaire.responses.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to [ @questionnaire, @response ], notice: "Response was successfully created." }
        format.json { render :show, status: :created, location: @response }
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
      params.require(:response).permit(:questionnaire_id, :participant_id, :sitting_id, answers: {})
    end
end
