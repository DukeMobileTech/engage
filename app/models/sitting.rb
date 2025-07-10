# == Schema Information
#
# Table name: sittings
#
#  id           :bigint           not null, primary key
#  completed    :boolean          default(FALSE)
#  discarded_at :datetime
#  done_on      :datetime
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  section_id   :integer          not null
#
# Indexes
#
#  index_sittings_on_discarded_at  (discarded_at)
#  index_sittings_on_section_id    (section_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#
class Sitting < ApplicationRecord
  include Discard::Model
  belongs_to :section
  delegate :site, to: :section, allow_nil: true
  has_many :attendances, dependent: :destroy
  has_many :responses, dependent: :nullify
  has_many :user_sittings, dependent: :destroy
  has_many :users, through: :user_sittings
  has_many :sitting_lessons, dependent: :destroy
  has_many :lessons, through: :sitting_lessons
  has_many :activities, through: :lessons
  has_many :lesson_attendances, through: :sitting_lessons

  validates :done_on, presence: true
  validates :section_id, presence: true
  validate :completion_conditions

  def present_participants
    lesson_attendances.where(present: true)
  end

  def average_attendance
    return 0 if present_participants.empty?
    ((present_participants.size.to_f / lesson_attendances.size) * 100).round(2)
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

  def fidelity_log_responses
    responses.where(questionnaire_id: Questionnaire.fidelity&.id)
  end

  def program_observation_responses
    responses.where(questionnaire_id: Questionnaire.observation&.id)
  end

  def status
    if completed?
      "completed"
    elsif !completed? && (present_participants.any? || fidelity_log_responses.any? || program_observation_responses.any?)
      "in-progress"
    else
      "not-started"
    end
  end

  private
    def completion_conditions
      if completed? && present_participants.empty?
        errors.add(:completed, "can't be true if no participants attended session")
      end
      if completed? && fidelity_log_responses.empty?
        errors.add(:completed, "can't be true if no fidelity log response")
      end
    end
end
