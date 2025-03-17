# == Schema Information
#
# Table name: sites
#
#  id              :integer          not null, primary key
#  code            :string           not null
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#
# Indexes
#
#  index_sites_on_code             (code) UNIQUE
#  index_sites_on_organization_id  (organization_id)
#
require "test_helper"

class SiteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
