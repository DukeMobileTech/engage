class SessionsController < ApplicationController
  before_action :set_site
  before_action :set_section
  before_action :set_lessons, only: %i[ new edit ]
  before_action :set_session, only: %i[ show edit update destroy ]

  # GET /sessions or /sessions.json
  def index
    @sessions = @section.sessions
  end

  # GET /sessions/1 or /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = @section.sessions.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions or /sessions.json
  def create
    @session = @section.sessions.new(session_params)

    respond_to do |format|
      if @session.save
        format.html { redirect_to site_section_session_path(@site, @section, @session), notice: "Session was successfully created." }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessions/1 or /sessions/1.json
  def update
    params[:session][:attendances_attributes]&.each do |index, attendance|
      @session.attendances.find(attendance["id"]).update(present: attendance["present"])
    end
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to site_section_session_path(@site, @section, @session), notice: "Session was successfully updated." }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1 or /sessions/1.json
  def destroy
    @session.destroy!

    respond_to do |format|
      format.html { redirect_to site_section_sessions_path(@site, @section), status: :see_other, notice: "Session was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = @section.sessions.find(params.expect(:id))
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
    def session_params
      params.expect(session: [ :done_on, :section_id, :lesson_id, attendances_attributes: [ :id, :participant_id, :session_id, :present ] ])
    end
end
