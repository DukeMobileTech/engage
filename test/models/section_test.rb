# == Schema Information
#
# Table name: sections
#
#  id            :integer          not null, primary key
#  completed     :boolean          default(FALSE)
#  end_date      :date
#  name          :string
#  start_date    :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  curriculum_id :integer          not null
#  site_id       :integer          not null
#
# Indexes
#
#  index_sections_on_curriculum_id  (curriculum_id)
#  index_sections_on_site_id        (site_id)
#
# Foreign Keys
#
#  curriculum_id  (curriculum_id => curriculums.id)
#  site_id        (site_id => sites.id)
#
require "test_helper"

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
