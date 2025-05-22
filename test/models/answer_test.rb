# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  label       :string
#  number      :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  fixtures :answers, :questions

  def setup
    @question = questions(:one)
    @answer = answers(:one)
  end

  test "should be valid with valid attributes" do
    assert @answer.valid?
  end

  test "should not be valid without a text" do
    @answer.text = nil
    assert_not @answer.valid?
  end

  test "should not be valid without a question" do
    @answer.question = nil
    assert_not @answer.valid?
  end

  test "should have a valid question_id" do
    @answer.save
    assert_equal @question.id, @answer.question_id
  end

  test "default scope orders answers by number" do
    second_answer = answers(:two)
    assert_equal [ @answer, second_answer ], Answer.all.to_a
  end
end
