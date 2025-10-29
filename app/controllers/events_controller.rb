class EventsController < ApplicationController
  before_action :set_questionnaire
  after_action :verify_authorized

  def index
    @events = @questionnaire.responses.kept.order(created_at: :desc)
    authorize @events
  end

  def show
    @event = @questionnaire.responses.kept.find(params[:id])
    authorize @event
  end

  def destroy
    @event = @questionnaire.responses.kept.find(params[:id])
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
    tempfile = Tempfile.new([ "#{@questionnaire.title.parameterize}", ".csv" ])
    tempfile.write(Response.to_csv(@questionnaire.id))
    tempfile.rewind

    send_file tempfile.path, filename: "#{@questionnaire.title.parameterize}.csv", type: "text/csv"
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find_by(title: "Community Engagement Tracking")
  end
end
