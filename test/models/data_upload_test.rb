# == Schema Information
#
# Table name: data_uploads
# Database name: primary
#
#  id                     :bigint           not null, primary key
#  include_site           :boolean          default(FALSE)
#  name                   :string
#  reporting_period_end   :date
#  reporting_period_start :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class DataUploadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
