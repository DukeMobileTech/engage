require "application_system_test_case"

class SiteParticipantsTest < ApplicationSystemTestCase
  setup do
    @site_participant = site_participants(:one)
  end

  test "visiting the index" do
    visit site_participants_url
    assert_selector "h1", text: "Site participants"
  end

  test "should create site participant" do
    visit site_participants_url
    click_on "New site participant"

    click_on "Create Site participant"

    assert_text "Site participant was successfully created"
    click_on "Back"
  end

  test "should update Site participant" do
    visit site_participant_url(@site_participant)
    click_on "Edit this site participant", match: :first

    click_on "Update Site participant"

    assert_text "Site participant was successfully updated"
    click_on "Back"
  end

  test "should destroy Site participant" do
    visit site_participant_url(@site_participant)
    click_on "Destroy this site participant", match: :first

    assert_text "Site participant was successfully destroyed"
  end
end
