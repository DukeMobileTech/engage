# == Schema Information
#
# Table name: questions
#
#  id                  :bigint           not null, primary key
#  answer_instructions :text
#  identifier          :string           not null
#  number              :integer
#  question_type       :integer
#  required            :boolean          default(TRUE)
#  text                :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  questionnaire_id    :integer          not null
#
# Indexes
#
#  index_questions_on_identifier        (identifier) UNIQUE
#  index_questions_on_questionnaire_id  (questionnaire_id)
#
# Foreign Keys
#
#  fk_rails_...  (questionnaire_id => questionnaires.id)
#
class Question < ApplicationRecord
  default_scope { order(:number) }
  belongs_to :questionnaire
  has_many :answers, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :answers, allow_destroy: true

  enum :question_type, { long_answer: 0, single_choice: 1, multiple_choice: 2, number_answer: 3, text: 4 }

  def self.question_type_enum
    question_types.keys.map { |k| [ k.titleize, k ] }
  end

  def question_answer(response)
    return nil if response.nil? || question_type == "text"

    ans = case question_type
    when "single_choice"
            answers.find { |a| a.id.to_s == response.answers[id.to_s] }&.text
    when "multiple_choice"
            selected_answers = []
            answers.select { |a| response.multiple_choice_answers(id).include?(a.id) }.each do |answer|
              selected_answers << answer.text
            end
            selected_answers.join(", ")
    else
            response.answers[id.to_s]
    end
    ans.blank? ? "-" : ans
  end
end
