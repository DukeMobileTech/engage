class EventsController < ApplicationController
  before_action :set_questionnaire

  def index
    @events = @questionnaire.responses.kept.order(created_at: :desc)
  end

  def show
    @event = @questionnaire.responses.kept.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find_by(title: "Community Engagement Tracking")
  end
end
