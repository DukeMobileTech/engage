require "test_helper"

class SectionParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_participant = section_participants(:one)
  end

  test "should get index" do
    get section_participants_url
    assert_response :success
  end

  test "should get new" do
    get new_section_participant_url
    assert_response :success
  end

  test "should create section_participant" do
    assert_difference("SectionParticipant.count") do
      post section_participants_url, params: { section_participant: {} }
    end

    assert_redirected_to section_participant_url(SectionParticipant.last)
  end

  test "should show section_participant" do
    get section_participant_url(@section_participant)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_participant_url(@section_participant)
    assert_response :success
  end

  test "should update section_participant" do
    patch section_participant_url(@section_participant), params: { section_participant: {} }
    assert_redirected_to section_participant_url(@section_participant)
  end

  test "should destroy section_participant" do
    assert_difference("SectionParticipant.count", -1) do
      delete section_participant_url(@section_participant)
    end

    assert_redirected_to section_participants_url
  end
end
