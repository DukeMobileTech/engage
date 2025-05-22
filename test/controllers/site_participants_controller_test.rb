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
end
