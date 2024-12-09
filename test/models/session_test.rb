# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  done_on    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :integer          not null
#  section_id :integer          not null
#
# Indexes
#
#  index_sessions_on_lesson_id   (lesson_id)
#  index_sessions_on_section_id  (section_id)
#
# Foreign Keys
#
#  lesson_id   (lesson_id => lessons.id)
#  section_id  (section_id => sections.id)
#
require "test_helper"

class SessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
