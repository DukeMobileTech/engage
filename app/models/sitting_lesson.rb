# == Schema Information
#
# Table name: sitting_lessons
#
#  id         :bigint           not null, primary key
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
#  fk_rails_...  (lesson_id => lessons.id)
#  fk_rails_...  (sitting_id => sittings.id)
#
class SittingLesson < ApplicationRecord
  belongs_to :lesson
  belongs_to :sitting
  has_many :lesson_attendances, dependent: :destroy

  after_create :take_attendance

  accepts_nested_attributes_for :lesson_attendances, reject_if: :all_blank, allow_destroy: true

  def name
    "#{lesson.title} on #{sitting.done_on.strftime("%F %H:%M %p")}"
  end

  def present_participants
    lesson_attendances.where(present: true)
  end

  def participation
    "#{present_participants.count} out of #{sitting.section.section_participants.count }"
  end
end
