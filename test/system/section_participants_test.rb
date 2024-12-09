require "application_system_test_case"

class SectionParticipantsTest < ApplicationSystemTestCase
  setup do
    @section_participant = section_participants(:one)
  end

  test "visiting the index" do
    visit section_participants_url
    assert_selector "h1", text: "Section participants"
  end

  test "should create section participant" do
    visit section_participants_url
    click_on "New section participant"

    click_on "Create Section participant"

    assert_text "Section participant was successfully created"
    click_on "Back"
  end

  test "should update Section participant" do
    visit section_participant_url(@section_participant)
    click_on "Edit this section participant", match: :first

    click_on "Update Section participant"

    assert_text "Section participant was successfully updated"
    click_on "Back"
  end

  test "should destroy Section participant" do
    visit section_participant_url(@section_participant)
    click_on "Destroy this section participant", match: :first

    assert_text "Section participant was successfully destroyed"
  end
end
