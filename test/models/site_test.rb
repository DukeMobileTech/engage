# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  county     :string
#  name       :string
#  setting    :string
#  state      :string
#  urbanicity :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sites_on_code  (code) UNIQUE
#
require "test_helper"

class SiteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
