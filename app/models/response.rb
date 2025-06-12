# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  answers          :json
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  participant_id   :integer
#  questionnaire_id :integer          not null
#  sitting_id       :integer
#  user_id          :integer
#
# Indexes
#
#  index_responses_on_discarded_at      (discarded_at)
#  index_responses_on_participant_id    (participant_id)
#  index_responses_on_questionnaire_id  (questionnaire_id)
#  index_responses_on_sitting_id        (sitting_id)
#  index_responses_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (participant_id => participants.id)
#  fk_rails_...  (questionnaire_id => questionnaires.id)
#  fk_rails_...  (sitting_id => sittings.id)
#
class Response < ApplicationRecord
  include Discard::Model
  belongs_to :questionnaire
  belongs_to :participant, optional: true
  belongs_to :sitting, optional: true
  belongs_to :user, optional: true
  has_many :section_participant_responses, dependent: :destroy

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

  def index_demo_label
    "#{participant&.name} (SEX: #{single_choice_answer('sex')} GRADE: #{single_choice_answer('grade')} DATE: #{created_at.strftime("%F")})"
  end

  def single_choice_answer(identifier)
    form = Questionnaire.find_by(title: "demographics")

    return nil unless form.id == questionnaire_id

    question = form.questions.find_by(identifier: identifier)
    return nil unless question

    question.answers.find { |a| a.id.to_s == answers[question.id.to_s] }&.text
  end

  def activity_answers(activity_id, question_id)
    index = answers["#{activity_id}_#{question_id}"]
    question = Question.find(question_id)
    if question.question_type == "single_choice"
      question.answers.where(id: index.to_i).first.text
    else
      index
    end
  end

  def observation?
    questionnaire&.observation?
  end

  def fidelity?
    questionnaire&.fidelity?
  end

  def demographics?
    questionnaire&.demographics?
  end
end
