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
#  section_id :integer          not null
#
# Indexes
#
#  index_sittings_on_section_id  (section_id)
#
# Foreign Keys
#
#  section_id  (section_id => sections.id)
#
class Sitting < ApplicationRecord
  belongs_to :section
  delegate :site, to: :section, allow_nil: true
  has_many :attendances, dependent: :destroy
  has_many :responses, dependent: :nullify
  has_many :user_sittings, dependent: :destroy
  has_many :users, through: :user_sittings
  has_many :sitting_lessons, dependent: :destroy
  has_many :lessons, through: :sitting_lessons
  has_many :activities, through: :lessons

  accepts_nested_attributes_for :attendances, reject_if: :all_blank, allow_destroy: true

  after_create :take_attendance

  validates :done_on, presence: true
  validates :section_id, presence: true

  def present_participants
    attendances.where(present: true)
  end

  def participation
    "#{present_participants.count} out of #{section.section_participants.count}"
  end

  def demographic_responses
    responses.where(questionnaire_id: Questionnaire.demographics&.id)
  end

  def title
    "#{lessons.map(&:title).join(", ")} sitting on #{done_on.strftime("%F %H:%M %p")}"
  end

  def label
    name || title
  end

  private

    def take_attendance
      section.participants.each do |participant|
        attendances.create(participant: participant)
      end
    end
end
