# == Schema Information
#
# Table name: sittings
#
#  id         :integer          not null, primary key
#  completed  :boolean          default(FALSE)
#  done_on    :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :integer          not null
#  section_id :integer          not null
#
# Indexes
#
#  index_sittings_on_lesson_id   (lesson_id)
#  index_sittings_on_section_id  (section_id)
#
# Foreign Keys
#
#  lesson_id   (lesson_id => lessons.id)
#  section_id  (section_id => sections.id)
#
require "test_helper"

class SittingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
