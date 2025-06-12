# == Schema Information
#
# Table name: organizations
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  name         :string           not null
#  setting      :string
#  state        :string
#  urbanicity   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_organizations_on_discarded_at  (discarded_at)
#
require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
