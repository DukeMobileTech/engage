require "application_system_test_case"

class SiteParticipantsTest < ApplicationSystemTestCase
  setup do
    @site_participant = site_participants(:one)
    @site = sites(:one)
    @participant = participants(:one)
    sign_in
  end

  test "visiting the index" do
    visit site_site_participants_url(@site)
    assert_selector "h2", text: @site.name
    assert_selector "h4", text: "Site Participants"
    assert_button "Search"
    assert_field "Search by name or study id or category"
    assert_table "site-participants"
    assert_link "Enroll new participants"
    assert_link "Enroll existing participants"
  end

  test "should enroll existing participants" do
    visit site_site_participants_url(@site)
    click_on "Enroll existing participants"
    assert_selector "h4", text: "Enroll Participants To Site"
    assert_selector "p", text: "Select the participants you want enrolled on this site"
    check("select-all")
    click_on "Save"

    assert_text "Site was successfully updated."
  end

  test "should enroll new participants" do
    visit site_site_participants_url(@site)
    click_on "Enroll new participants"
    assert_selector "h4", text: "New Participants"
    assert_button "Remove participant"
    assert_button "Add participant"
    assert_button "Save participants"
    fill_in "Name", with: @participant.name
    click_on "Add participant"
    all(:fillable_field, "Name").last.set("Doe")
    click_on "Save participants"
    assert_current_path site_site_participants_path(@site)
  end
end
