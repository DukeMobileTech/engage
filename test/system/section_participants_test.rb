require "application_system_test_case"

class SectionParticipantsTest < ApplicationSystemTestCase
  setup do
    @section_participant = section_participants(:three)
    @section = sections(:two)
    @site = sites(:two)
    sign_in
  end

  test "visiting the index" do
    visit site_section_section_participants_url(@site, @section)
    assert_selector "h4", text: "Participants Enrolled In #{@section.name}"
    assert_button "Search"
    assert_field "Search by name or study id or category"
    assert_table "section-participants"
    assert_link "Enroll participants"
  end

  test "should enroll section participants" do
    visit site_section_section_participants_url(@site, @section)
    click_on "Enroll participants"
    assert_selector "h4", text: "Enrolling participants to section"
    assert_selector "p", text: "Select the participants you want enrolled in this section"
    check("select-all")
    click_on "Save"

    assert_text "Section was successfully updated."
  end

  # test "should update Section participant" do
  #   visit section_participant_url(@section_participant)
  #   click_on "Edit this section participant", match: :first

  #   click_on "Update Section participant"

  #   assert_text "Section participant was successfully updated"
  #   click_on "Back"
  # end

  # test "should destroy Section participant" do
  #   visit section_participant_url(@section_participant)
  #   click_on "Destroy this section participant", match: :first

  #   assert_text "Section participant was successfully destroyed"
  # end
end
