# == Schema Information
#
# Table name: questionnaires
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Questionnaire < ApplicationRecord
  has_many :questions, dependent: :destroy, inverse_of: :questionnaire
  has_many :responses, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  def fidelity_questions(sitting_id)
    looped = []
    question = questions.find_or_create_by(identifier: "activities")
    sitting = Sitting.find(sitting_id)
    lesson = sitting.lesson
    lesson.activities.each do |activity|
      quest = question.dup
      quest.text = activity.name
      quest.answers = question.answers.map { |a| a.dup }
      looped << quest
    end
    looped + (questions - [ question ])
  end
end
