# == Schema Information
#
# Table name: sections
#
#  id            :bigint           not null, primary key
#  completed     :boolean          default(FALSE)
#  discarded_at  :datetime
#  end_date      :date
#  name          :string
#  reported      :boolean          default(TRUE)
#  start_date    :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  curriculum_id :integer          not null
#  site_id       :integer          not null
#
# Indexes
#
#  index_sections_on_curriculum_id  (curriculum_id)
#  index_sections_on_discarded_at   (discarded_at)
#  index_sections_on_site_id        (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (curriculum_id => curriculums.id)
#  fk_rails_...  (site_id => sites.id)
#
require "test_helper"

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
