class DataUploadReportJob < ApplicationJob
  queue_as :default

  def perform(data_upload)
    # start the report generation
    data_upload.generate_report
  end
end
