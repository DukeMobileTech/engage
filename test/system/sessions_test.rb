require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    @session = sessions(:one)
  end

  test "visiting the index" do
    visit sessions_url
    assert_selector "h1", text: "Sessions"
  end

  test "should create session" do
    visit sessions_url
    click_on "New session"

    fill_in "Done on", with: @session.done_on
    fill_in "Lesson", with: @session.lesson_id
    fill_in "Section", with: @session.section_id
    click_on "Create Session"

    assert_text "Session was successfully created"
    click_on "Back"
  end

  test "should update Session" do
    visit session_url(@session)
    click_on "Edit this session", match: :first

    fill_in "Done on", with: @session.done_on.to_s
    fill_in "Lesson", with: @session.lesson_id
    fill_in "Section", with: @session.section_id
    click_on "Update Session"

    assert_text "Session was successfully updated"
    click_on "Back"
  end

  test "should destroy Session" do
    visit session_url(@session)
    click_on "Destroy this session", match: :first

    assert_text "Session was successfully destroyed"
  end
end
