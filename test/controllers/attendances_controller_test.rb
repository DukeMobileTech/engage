require "test_helper"

class AttendancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sitting = sittings(:one)
    @section = sections(:one)
    @site = sites(:one)
    sign_in
  end

  test "should get index" do
    get site_section_sitting_attendances_url(
      site_id: @site.id,
      section_id: @section.id,
      sitting_id: @sitting.id
    )
    assert_response :success
  end
end
