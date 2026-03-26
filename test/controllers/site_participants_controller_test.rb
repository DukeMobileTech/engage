require "test_helper"

class SiteParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site_participant = site_participants(:one)
    @site = sites(:one)
    sign_in
  end

  test "should get index" do
    get site_site_participants_url(@site)
    assert_response :success
  end

  test "should only include kept participants in index" do
    participants(:two).discard

    get site_site_participants_url(@site)
    assert_response :success

    site_participants = assigns(:site_participants)
    assert_equal 1, site_participants.size
    assert_equal participants(:one).id, site_participants.first.participant_id
  end
end
