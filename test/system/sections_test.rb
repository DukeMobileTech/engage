require "application_system_test_case"

class SectionsTest < ApplicationSystemTestCase
  setup do
    @section = sections(:one)
  end

  test "visiting the index" do
    visit sections_url
    assert_selector "h1", text: "Sections"
  end

  test "should create section" do
    visit sections_url
    click_on "New section"

    fill_in "Curriculum", with: @section.curriculum_id
    fill_in "End date", with: @section.end_date
    fill_in "Name", with: @section.name
    fill_in "Site", with: @section.site_id
    fill_in "Start date", with: @section.start_date
    click_on "Create Section"

    assert_text "Section was successfully created"
    click_on "Back"
  end

  test "should update Section" do
    visit section_url(@section)
    click_on "Edit this section", match: :first

    fill_in "Curriculum", with: @section.curriculum_id
    fill_in "End date", with: @section.end_date.to_s
    fill_in "Name", with: @section.name
    fill_in "Site", with: @section.site_id
    fill_in "Start date", with: @section.start_date.to_s
    click_on "Update Section"

    assert_text "Section was successfully updated"
    click_on "Back"
  end

  test "should destroy Section" do
    visit section_url(@section)
    click_on "Destroy this section", match: :first

    assert_text "Section was successfully destroyed"
  end
end
