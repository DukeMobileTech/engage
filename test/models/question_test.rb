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
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
