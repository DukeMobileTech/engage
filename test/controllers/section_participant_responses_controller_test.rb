require "test_helper"

class SectionParticipantResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_participant_response = section_participant_responses(:one)
  end

  test "should get index" do
    get section_participant_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_section_participant_response_url
    assert_response :success
  end

  test "should create section_participant_response" do
    assert_difference("SectionParticipantResponse.count") do
      post section_participant_responses_url, params: { section_participant_response: { response_id: @section_participant_response.response_id, section_participant_id: @section_participant_response.section_participant_id } }
    end

    assert_redirected_to section_participant_response_url(SectionParticipantResponse.last)
  end

  test "should show section_participant_response" do
    get section_participant_response_url(@section_participant_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_participant_response_url(@section_participant_response)
    assert_response :success
  end

  test "should update section_participant_response" do
    patch section_participant_response_url(@section_participant_response), params: { section_participant_response: { response_id: @section_participant_response.response_id, section_participant_id: @section_participant_response.section_participant_id } }
    assert_redirected_to section_participant_response_url(@section_participant_response)
  end

  test "should destroy section_participant_response" do
    assert_difference("SectionParticipantResponse.count", -1) do
      delete section_participant_response_url(@section_participant_response)
    end

    assert_redirected_to section_participant_responses_url
  end
end
