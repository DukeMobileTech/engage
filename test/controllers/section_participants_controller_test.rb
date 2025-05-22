require "test_helper"

class SectionParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_participant = section_participants(:one)
    @section = sections(:one)
    @site = sites(:one)
    sign_in
  end

  test "should get index" do
    get site_section_section_participants_url(@site, @section)
    assert_response :success
  end

  test "should show section_participant" do
    get site_section_section_participant_url(@site, @section, @section_participant)
    assert_response :success
  end
end
