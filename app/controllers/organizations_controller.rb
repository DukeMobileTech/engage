class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[ show edit update destroy ]
  after_action :verify_authorized

  # GET /organizations or /organizations.json
  def index
    user = Current.user
    if user.admin?
      @query = Organization.kept.ransack(params[:query])
    else
      @query = user.organizations.kept.ransack(params[:query])
    end
    @organizations = @query.result(distinct: true)
                           .page(params[:page])
                           .per(params[:per_page] || 25)
                           .includes(:sites)
                           .order("name ASC")
    authorize @organizations
  end

  # GET /organizations/1 or /organizations/1.json
  def show
    authorize @organization
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    authorize @organization
  end

  # GET /organizations/1/edit
  def edit
    authorize @organization
  end

  # POST /organizations or /organizations.json
  def create
    @organization = Organization.new(organization_params)
    authorize @organization

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: "Organization was successfully created." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1 or /organizations/1.json
  def update
    authorize @organization
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1 or /organizations/1.json
  def destroy
    authorize @organization
    @organization.discard

    respond_to do |format|
      format.html { redirect_to organizations_path, status: :see_other, notice: "Organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.expect(organization: [ :name, :state, :urbanicity, :setting ])
    end
end
