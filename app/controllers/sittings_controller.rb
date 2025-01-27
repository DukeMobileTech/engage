class SittingsController < ApplicationController
  before_action :set_site
  before_action :set_section
  before_action :set_lessons, only: %i[ new edit ]
  before_action :set_sitting, only: %i[ show edit update destroy ]

  # GET /sittings or /sittings.json
  def index
    @sittings = @section.sittings.order(done_on: :desc)
  end

  # GET /sittings/1 or /sittings/1.json
  def show
  end

  # GET /sittings/new
  def new
    @sitting = @section.sittings.new
  end

  # GET /sittings/1/edit
  def edit
    if @sitting.attendances.size != @section.participants.size
      @section.participants.each do |participant|
        @sitting.attendances.find_or_create_by(participant_id: participant.id)
      end
    end
  end

  # POST /sittings or /sittings.json
  def create
    @sitting = @section.sittings.new(sitting_params)

    respond_to do |format|
      if @sitting.save
        format.html { redirect_to site_section_sitting_path(@site, @section, @sitting), notice: "Sitting was successfully created." }
        format.json { render :show, status: :created, location: @sitting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sittings/1 or /sittings/1.json
  def update
    if params[:sitting]
      params[:sitting][:attendances_attributes]&.each do |index, attendance|
        @sitting.attendances.find(attendance["id"]).update(present: attendance["present"])
      end
    end
    respond_to do |format|
      if @sitting.update(sitting_params)
        format.html { redirect_to site_section_sitting_path(@site, @section, @sitting), notice: "Sitting was successfully updated." }
        format.json { render :show, status: :ok, location: @sitting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sittings/1 or /sittings/1.json
  def destroy
    @sitting.destroy!

    respond_to do |format|
      format.html { redirect_to site_section_sittings_path(@site, @section), status: :see_other, notice: "Sitting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sitting
      @sitting = @section.sittings.find(params.expect(:id))
    end

    def set_section
      @section = @site.sections.find(params.expect(:section_id))
    end

    def set_site
      @site = Site.find(params.expect(:site_id))
    end

    def set_lessons
      @lessons = @section.curriculum.lessons
    end

    # Only allow a list of trusted parameters through.
    def sitting_params
      params.expect(sitting: [ :name, :done_on, :section_id, :lesson_id, :completed, attendances_attributes: [ :id, :participant_id, :sitting_id, :present ] ])
    end
end
