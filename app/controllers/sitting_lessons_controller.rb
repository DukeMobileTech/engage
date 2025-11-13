class SittingLessonsController < ApplicationController
  before_action :set_path_params, only: %i[ show edit update ]

  # GET /sitting_lessons/1
  def show
    @lesson_attendances = @sitting_lesson.enrolled_participants_lesson_attendances.includes(:participant).order("participants.name")
  end

  # GET /sitting_lessons/1/edit
  def edit
    @lesson_attendances = @sitting_lesson.enrolled_participants_lesson_attendances.includes(:participant).order("participants.name")
    @participants = @sitting.section.participants.order(:name)
  end

  # PATCH/PUT /sitting_lessons/1
  def update
    if @sitting_lesson.update(sitting_lesson_params)
      redirect_to [ @site, @section, @sitting, @sitting_lesson ], notice: "Sitting lesson was successfully updated."
    else
      render :edit
    end
  end

  private
    def set_path_params
      @site = Site.find(params.expect(:site_id))
      @section = @site.sections.find(params.expect(:section_id))
      @sitting = @section.sittings.find(params.expect(:sitting_id))
      @sitting_lesson = @sitting.sitting_lessons.find(params.expect(:id))
    end

    def sitting_lesson_params
      params.require(:sitting_lesson).permit(:lesson_id, :sitting_id, lesson_attendances_attributes: [ :id, :sitting_lesson_id, :participant_id, :present ])
    end
end
