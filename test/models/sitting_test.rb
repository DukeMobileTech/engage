# == Schema Information
#
# Table name: sittings
#
#  id         :bigint           not null, primary key
#  completed  :boolean          default(FALSE)
#  done_on    :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :integer          not null
#
# Indexes
#
#  index_sittings_on_section_id  (section_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#
require "test_helper"

class SittingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
