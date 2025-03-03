class DataTrackerReportJob < ApplicationJob
  queue_as :default

  def perform(section)
    section.generate_data_tracker
  end
end
