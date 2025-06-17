# == Schema Information
#
# Table name: lesson_attendances
#
#  id                :bigint           not null, primary key
#  present           :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  participant_id    :bigint           not null
#  sitting_lesson_id :bigint           not null
#
# Indexes
#
#  index_lesson_attendances_on_participant_id     (participant_id)
#  index_lesson_attendances_on_sitting_lesson_id  (sitting_lesson_id)
#
# Foreign Keys
#
#  fk_rails_...  (participant_id => participants.id)
#  fk_rails_...  (sitting_lesson_id => sitting_lessons.id)
#
class LessonAttendance < ApplicationRecord
  belongs_to :participant
  belongs_to :sitting_lesson
end
