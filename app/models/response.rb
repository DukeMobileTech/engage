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
#  session_id       :integer
#
# Indexes
#
#  index_responses_on_participant_id    (participant_id)
#  index_responses_on_questionnaire_id  (questionnaire_id)
#  index_responses_on_session_id        (session_id)
#
# Foreign Keys
#
#  participant_id    (participant_id => participants.id)
#  questionnaire_id  (questionnaire_id => questionnaires.id)
#  session_id        (session_id => sessions.id)
#
class Response < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :participant, optional: true
  belongs_to :session, optional: true

  validates :answers, presence: true

  def multiple_choice_answers(id)
    return [] if answers[id.to_s].nil?
    answers[id.to_s].map(&:to_i)
  end
end
