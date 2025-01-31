# == Schema Information
#
# Table name: sitting_lessons
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :integer          not null
#  sitting_id :integer          not null
#
# Indexes
#
#  index_sitting_lessons_on_lesson_id   (lesson_id)
#  index_sitting_lessons_on_sitting_id  (sitting_id)
#
# Foreign Keys
#
#  lesson_id   (lesson_id => lessons.id)
#  sitting_id  (sitting_id => sittings.id)
#
require "test_helper"

class SittingLessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
