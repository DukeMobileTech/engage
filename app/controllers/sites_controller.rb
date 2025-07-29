class SitesController < ApplicationController
  before_action :set_site, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  # GET /sites or /sites.json
  def index
    user = Current.user
    if user.admin?
      @query = Site.kept.ransack(params[:query])
    else
      @query = user.sites.kept.ransack(params[:query])
    end
    @sites = @query.result(distinct: true)
                   .page(params[:page])
                   .per(params[:per_page] || 25)
                   .includes(:organization, :participants, :sections)
                   .order("name ASC")
    authorize @sites
  end

  # GET /sites/1 or /sites/1.json
  def show
    authorize @site
  end

  # GET /sites/new
  def new
    @site = Site.new
    authorize @site
  end

  # GET /sites/1/edit
  def edit
    authorize @site
    @participants = Participant.kept
  end

  # POST /sites or /sites.json
  def create
    @site = Site.new(site_params)
    authorize @site

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: "Site was successfully created." }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1 or /sites/1.json
  def update
    authorize @site
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: "Site was successfully updated." }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1 or /sites/1.json
  def destroy
    authorize @site
    @site.discard

    respond_to do |format|
      format.html { redirect_to sites_path, status: :see_other, notice: "Site was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def site_params
      params.require(:site).permit(:name, :code, :county, :organization_id, participant_ids: [])
    end
end
