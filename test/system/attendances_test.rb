require "application_system_test_case"

class AttendancesTest < ApplicationSystemTestCase
  setup do
    @site = sites(:one)
    @section = sections(:one)
    @sitting = sittings(:one)
    @attendance = attendances(:one)
    sign_in
  end

  test "visiting the index" do
    visit site_section_sitting_attendances_url(@site, @section, @sitting)
    assert_selector "h4", text: "Participant Attendance For #{@sitting.name} on #{@sitting.done_on.strftime("%F %H:%M %p")}"
    assert_selector "table thead tr th", text: "NAME"
    assert_selector "table thead tr th", text: "CATEGORY"
    assert_selector "table thead tr th", text: "SEX"
    assert_selector "table thead tr th", text: "AGE"
    assert_selector "table thead tr th", text: "PRESENT"
    assert_link "Edit Attendance"
  end

  test "edit attendance link" do
    visit site_section_sitting_attendances_url(@site, @section, @sitting)
    click_on "Edit Attendance"
    assert_selector "h4", text: "Taking Attendance For #{@sitting.name}"
  end
end
