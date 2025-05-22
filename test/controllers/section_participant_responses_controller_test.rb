require "test_helper"

class SectionParticipantResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_participant_response = section_participant_responses(:one)
    @section_participant = section_participants(:one)
    @section = sections(:one)
    @site = sites(:one)
    @response = responses(:three)
    sign_in
  end

  test "should get new" do
    get new_site_section_section_participant_section_participant_response_url(@site, @section, @section_participant)
    assert_response :success
  end

  test "should create section_participant_response" do
    assert_difference("SectionParticipantResponse.count") do
      post site_section_section_participant_section_participant_responses_url(@site, @section, @section_participant), params: { section_participant_response: { response_id: @section_participant_response.response_id, section_participant_id: @section_participant_response.section_participant_id } }
    end

    assert_redirected_to site_section_section_participants_url(@site, @section)
  end

  test "should get edit" do
    get edit_site_section_section_participant_section_participant_response_url(@site, @section, @section_participant, @section_participant_response)
    assert_response :success
  end

  test "should update section_participant_response" do
    patch site_section_section_participant_section_participant_response_url(@site, @section, @section_participant, @section_participant_response), params: { section_participant_response: { response_id: @section_participant_response.response_id, section_participant_id: @section_participant_response.section_participant_id } }
    assert_redirected_to site_section_section_participants_url(@site, @section)
  end
end
