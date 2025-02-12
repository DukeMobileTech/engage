class DataUploadsController < ApplicationController
  before_action :set_data_upload, only: %i[ show edit update destroy generate_report]

  # GET /data_uploads or /data_uploads.json
  def index
    @data_uploads = DataUpload.all
  end

  # GET /data_uploads/1 or /data_uploads/1.json
  def show
  end

  # GET /data_uploads/new
  def new
    @data_upload = DataUpload.new
    @sections = Current.user.sections.where(completed: true)
  end

  # GET /data_uploads/1/edit
  def edit
    @sections = Current.user.sections.where(completed: true)
  end

  # POST /data_uploads or /data_uploads.json
  def create
    @data_upload = DataUpload.new(data_upload_params)

    respond_to do |format|
      if @data_upload.save
        format.html { redirect_to @data_upload, notice: "Data upload was successfully created." }
        format.json { render :show, status: :created, location: @data_upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @data_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_uploads/1 or /data_uploads/1.json
  def update
    respond_to do |format|
      if @data_upload.update(data_upload_params)
        format.html { redirect_to @data_upload, notice: "Data upload was successfully updated." }
        format.json { render :show, status: :ok, location: @data_upload }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @data_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_uploads/1 or /data_uploads/1.json
  def destroy
    @data_upload.destroy!

    respond_to do |format|
      format.html { redirect_to data_uploads_path, status: :see_other, notice: "Data upload was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def generate_report
    DataUploadReportJob.perform_later(@data_upload)
    redirect_to @data_upload, notice: "Report generation has been queued."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_upload
      @data_upload = DataUpload.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def data_upload_params
      params.expect(data_upload: [ :name, section_ids: [] ])
    end
end
