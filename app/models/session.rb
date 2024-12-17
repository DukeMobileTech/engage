# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  completed  :boolean          default(FALSE)
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
class Session < ApplicationRecord
  belongs_to :section
  belongs_to :lesson
  has_many :attendances, dependent: :destroy
  has_many :responses

  accepts_nested_attributes_for :attendances

  after_create :take_attendance

  validates :done_on, presence: true
  validates :section_id, presence: true
  validates :lesson_id, presence: true

  def present_participants
    attendances.where(present: true)
  end

  def participation
    "#{present_participants.count} out of #{section.section_participants.count}"
  end

  private

    def take_attendance
      section.participants.each do |participant|
        attendances.create(participant: participant)
      end
    end
end
