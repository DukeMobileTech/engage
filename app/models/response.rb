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
#  sitting_id       :integer
#  user_id          :integer
#
# Indexes
#
#  index_responses_on_participant_id    (participant_id)
#  index_responses_on_questionnaire_id  (questionnaire_id)
#  index_responses_on_sitting_id        (sitting_id)
#  index_responses_on_user_id           (user_id)
#
# Foreign Keys
#
#  participant_id    (participant_id => participants.id)
#  questionnaire_id  (questionnaire_id => questionnaires.id)
#  sitting_id        (sitting_id => sittings.id)
#
class Response < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :participant, optional: true
  belongs_to :sitting, optional: true
  belongs_to :user, optional: true
  has_many :section_participant_responses

  validates :answers, presence: true

  def multiple_choice_answers(id)
    return [] if answers[id.to_s].nil?
    answers[id.to_s].map(&:to_i)
  end

  def observer
    return nil unless questionnaire.observation?

    User.find_by(id: answers["observer_id"]&.to_i)
  end

  def facilitators
    return [] unless questionnaire.fidelity?
    return [] if sitting.nil?

    sitting.users
  end

  def demographics_label
    "<b>SEX:</b> #{single_choice_answer('sex')}; <b>AGE:</b> #{single_choice_answer('age')}; <b>GRADE:</b> #{single_choice_answer('grade')}; <b>DATE:</b> #{created_at.strftime("%F")}"
  end

  def single_choice_answer(identifier)
    form = Questionnaire.find_by(title: "demographics")

    return nil unless form.id == questionnaire_id

    question = form.questions.find_by(identifier: identifier)
    return nil unless question

    question.answers.find { |a| a.id.to_s == answers[question.id.to_s] }&.text
  end
end
