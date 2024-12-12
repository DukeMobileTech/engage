require "test_helper"

class SiteParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site_participant = site_participants(:one)
  end

  test "should get index" do
    get site_participants_url
    assert_response :success
  end

  test "should get new" do
    get new_site_participant_url
    assert_response :success
  end

  test "should create site_participant" do
    assert_difference("SiteParticipant.count") do
      post site_participants_url, params: { site_participant: {} }
    end

    assert_redirected_to site_participant_url(SiteParticipant.last)
  end

  test "should show site_participant" do
    get site_participant_url(@site_participant)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_participant_url(@site_participant)
    assert_response :success
  end

  test "should update site_participant" do
    patch site_participant_url(@site_participant), params: { site_participant: {} }
    assert_redirected_to site_participant_url(@site_participant)
  end

  test "should destroy site_participant" do
    assert_difference("SiteParticipant.count", -1) do
      delete site_participant_url(@site_participant)
    end

    assert_redirected_to site_participants_url
  end
end
