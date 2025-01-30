# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answers          :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  participant_id   :integer
#  questionnaire_id :integer          not null
#  section_id       :integer
#  sitting_id       :integer
#  user_id          :integer
#
# Indexes
#
#  index_responses_on_participant_id    (participant_id)
#  index_responses_on_questionnaire_id  (questionnaire_id)
#  index_responses_on_section_id        (section_id)
#  index_responses_on_sitting_id        (sitting_id)
#  index_responses_on_user_id           (user_id)
#
# Foreign Keys
#
#  participant_id    (participant_id => participants.id)
#  questionnaire_id  (questionnaire_id => questionnaires.id)
#  section_id        (section_id => sections.id)
#  sitting_id        (sitting_id => sittings.id)
#
class Response < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :participant, optional: true
  belongs_to :sitting, optional: true
  belongs_to :section, optional: true
  belongs_to :user, optional: true

  validates :answers, presence: true

  def multiple_choice_answers(id)
    return [] if answers[id.to_s].nil?
    answers[id.to_s].map(&:to_i)
  end

  def associate_section
    return if participant.nil?

    section = participant.sections.last
    update(section: section) if section.present?
  end

  def observer
    return nil unless questionnaire.observation?

    User.find_by(id: answers["observer_id"]&.to_i)
  end

  def facilitators
    return [] unless questionnaire.fidelity?

    sitting.users
  end
end
