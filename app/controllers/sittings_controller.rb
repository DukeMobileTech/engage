class SittingsController < ApplicationController
  before_action :set_site
  before_action :set_section
  before_action :set_lessons, only: %i[ new edit update bulk]
  before_action :set_sitting, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  # GET /sittings or /sittings.json
  def index
    @sittings = @section.sittings.kept.order(done_on: :desc)
    authorize @sittings
  end

  # GET /sittings/1 or /sittings/1.json
  def show
    authorize @sitting
  end

  # GET /sittings/new
  def new
    @sitting = @section.sittings.new
    @facilitators = @site.facilitators
    authorize @sitting
  end

  # GET /sittings/1/edit
  def edit
    @facilitators = @site.facilitators
    authorize @sitting
  end

  # POST /sittings or /sittings.json
  def create
    @sitting = @section.sittings.new(sitting_params)
    authorize @sitting

    respond_to do |format|
      if @sitting.save
        format.html { redirect_to site_section_sitting_path(@site, @section, @sitting), notice: "Session was successfully created." }
        format.json { render :show, status: :created, location: @sitting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sittings/1 or /sittings/1.json
  def update
    authorize @sitting
    @facilitators = @site.facilitators
    respond_to do |format|
      if @sitting.update(sitting_params)
        format.html { redirect_to site_section_sitting_path(@site, @section, @sitting), notice: "Session was successfully updated." }
        format.json { render :show, status: :ok, location: @sitting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sittings/1 or /sittings/1.json
  def destroy
    authorize @sitting
    @sitting.discard

    respond_to do |format|
      format.html { redirect_to site_section_sittings_path(@site, @section), status: :see_other, notice: "Session was successfully discarded." }
      format.json { head :no_content }
    end
  end

  def bulk
    @facilitators = @site.facilitators
    authorize @section.sittings.new
  end

  def bulk_create
    authorize @section.sittings.new
    params[:sittings].each do |attr|
      sitting = @section.sittings.create(name: attr[:name], done_on: attr[:done_on], completed: attr[:completed])
      lessons = Lesson.where(id: attr[:lesson_ids])
      users = User.where(id: attr[:user_ids])
      sitting.lessons << lessons
      sitting.users << users
    end
    redirect_to site_section_sittings_path(@site, @section)
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
      params.expect(sitting: [ :name, :done_on, :section_id, :completed, lessons_covered: [], user_ids: [], lesson_ids: [] ])
    end
end
