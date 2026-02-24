class EventsController < ApplicationController
  before_action :set_questionnaire, except: :index
  after_action :verify_authorized, except: [ :index, :show ]

  def index
    @questionnaires = Questionnaire.events.includes(:responses).order(:title)
  end

  def show
    @events = @questionnaire.responses.kept.order(created_at: :desc)
  end

  def destroy
    @event = @questionnaire.responses.kept.find(params[:response_id])
    authorize @event
    @event.discard
    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully discarded." }
      format.json { head :no_content }
    end
  end

  def download
    @events = @questionnaire.responses.kept
    authorize @events
    filename = "#{@questionnaire.title.parameterize}-#{Date.current.strftime('%Y-%m-%d')}.csv"
    tempfile = Tempfile.new filename
    tempfile.write(Response.to_csv(@questionnaire.id))
    tempfile.rewind

    send_file tempfile.path, filename: filename, type: "text/csv"
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end
end
