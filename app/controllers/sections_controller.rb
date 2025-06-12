class SectionsController < ApplicationController
  before_action :set_site
  before_action :set_curriculums
  before_action :set_section, only: %i[ show edit update destroy data_tracker ]
  after_action :verify_authorized

  # GET /sections or /sections.json
  def index
    @sections = @site.sections.kept
    authorize @sections
  end

  # GET /sections/1 or /sections/1.json
  def show
    authorize @section
  end

  # GET /sections/new
  def new
    @section = Section.new
    authorize @section
  end

  # GET /sections/1/edit
  def edit
    @participants = @site.participants if params[:enrollment]
    authorize @section
  end

  # POST /sections or /sections.json
  def create
    @section = @site.sections.new(section_params)
    authorize @section

    respond_to do |format|
      if @section.save
        format.html { redirect_to site_sections_path(@site), notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1 or /sections/1.json
  def update
    authorize @section
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to site_section_path(@site, @section), notice: "Section was successfully updated." }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1 or /sections/1.json
  def destroy
    authorize @section
    @section.discard

    respond_to do |format|
      format.html { redirect_to site_sections_path, status: :see_other, notice: "Section was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /sections/1/data_tracker
  def data_tracker
    authorize @section
    DataTrackerReportJob.perform_later(@section)
    redirect_to site_section_path(@site, @section)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = @site.sections.find(params.expect(:id))
    end

    def set_site
      @site = Site.find(params.expect(:site_id))
    end

    def set_curriculums
      @curriculums = Curriculum.all
    end

    # Only allow a list of trusted parameters through.
    def section_params
      params.expect(section: [ :name, :start_date, :end_date, :curriculum_id, :site_id, :completed, participant_ids: [] ])
    end
end
