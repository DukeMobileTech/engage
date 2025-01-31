class SectionsController < ApplicationController
  before_action :set_site
  before_action :set_section, only: %i[ show edit update destroy data_tracker ]
  before_action :set_curriculums, only: %i[ new edit ]

  # GET /sections or /sections.json
  def index
    @sections = @site.sections.all
  end

  # GET /sections/1 or /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
    @participants = @site.participants if params[:enrollment]
  end

  # POST /sections or /sections.json
  def create
    @section = @site.sections.new(section_params)

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
    @section.destroy!

    respond_to do |format|
      format.html { redirect_to site_sections_path, status: :see_other, notice: "Section was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /sections/1/data_tracker
  def data_tracker
    @section.generate_data_tracker
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
