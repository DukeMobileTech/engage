require "application_system_test_case"

class SittingsTest < ApplicationSystemTestCase
  setup do
    @sitting = sittings(:one)
  end

  test "visiting the index" do
    visit sittings_url
    assert_selector "h1", text: "sittings"
  end

  test "should create sitting" do
    visit sittings_url
    click_on "New sitting"

    fill_in "Done on", with: @sitting.done_on
    fill_in "Lesson", with: @sitting.lesson_id
    fill_in "Section", with: @sitting.section_id
    click_on "Create sitting"

    assert_text "sitting was successfully created"
    click_on "Back"
  end

  test "should update sitting" do
    visit sitting_url(@sitting)
    click_on "Edit this sitting", match: :first

    fill_in "Done on", with: @sitting.done_on.to_s
    fill_in "Lesson", with: @sitting.lesson_id
    fill_in "Section", with: @sitting.section_id
    click_on "Update sitting"

    assert_text "sitting was successfully updated"
    click_on "Back"
  end

  test "should destroy sitting" do
    visit sitting_url(@sitting)
    click_on "Destroy this sitting", match: :first

    assert_text "sitting was successfully destroyed"
  end
end
