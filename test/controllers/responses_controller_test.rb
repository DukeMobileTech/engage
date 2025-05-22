require "test_helper"

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @questionnaire = questionnaires(:three)
    @response = @questionnaire.responses.create(answers: { "1" => "Answer 1", "2" => "Answer 2" })
    sign_in
  end

  test "should get index" do
    get questionnaire_responses_url(@questionnaire)
    assert_response :success
  end

  test "should get new" do
    get new_questionnaire_response_url(@questionnaire)
    assert_response :success
  end

  test "should create response" do
    assert_difference("Response.count") do
      answers = { "1" => "Answer 1", "2" => "Answer 2" }
      post questionnaire_responses_url(@questionnaire), params: { response: { answers: answers, questionnaire_id: @questionnaire.id } }
    end

    assert_redirected_to questionnaire_response_url(@questionnaire, Response.last)
  end

  test "should show response" do
    @response = @questionnaire.responses.create(answers: { "1" => "Answer 1", "2" => "Answer 2" })
    get questionnaire_response_url(@questionnaire, @response)
    assert_response :success
  end
end
