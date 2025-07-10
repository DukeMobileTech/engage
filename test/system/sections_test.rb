require "application_system_test_case"

class SectionsTest < ApplicationSystemTestCase
  setup do
    @section = sections(:one)
    @site = sites(:one)
    sign_in
  end

  test "visiting the index" do
    visit site_sections_url(@site)
    assert_selector "h2", text: @site.name
    assert_selector "div.sidebar"
    assert_selector "main"
    assert_table "sections"
    assert_link "Add new section"
  end

  test "site details link" do
    visit site_sections_url(@site)
    assert_link "Details"
    click_on "Details"
    assert_selector "h4", text: "Site Details"
  end

  test "site participants link" do
    visit site_sections_url(@site)
    assert_link "Site Participants"
    click_on "Site Participants"
    assert_selector "h4", text: "Site Participants"
  end

  test "site sections link" do
    visit site_sections_url(@site)
    assert_link "Sections"
    click_on "Sections"
    assert_selector "h4", text: "Site Sections"
  end

  test "should create section" do
    visit site_sections_url(@site)
    click_on "Add new section"

    select(@section.curriculum.title, from: "section_curriculum_id")
    fill_in "End date", with: @section.end_date
    fill_in "Start date", with: @section.start_date
    click_on "Create Section"

    assert_text "Section was successfully created"
  end

  test "visiting the show section" do
    visit site_section_url(@site, @section)
    assert_selector "div", text: "Site Name: #{@site.name}"
    assert_selector "div", text: "Section Name: #{@section.name}"
    assert_link "Details"
    assert_link "Section Participants"
    assert_link "Sessions"
    assert_selector "h4", text: "#{@section.name} Program Details"
    assert_link "Edit this section"
    assert_selector "h4", text: "Program Observations"
    assert_link "View Observations"
    assert_selector "h4", text: "Data Tracker Reports"
    assert_link "Generate Data Tracker"
  end

  test "section details link" do
    visit site_section_url(@site, @section)
    assert_link "Details"
    click_on "Details"
    assert_selector "h4", text: "#{@section.name} Program Details"
  end

  test "section participants link" do
    visit site_section_url(@site, @section)
    assert_link "Section Participants"
    click_on "Section Participants"
    assert_selector "h4", text: "Participants Enrolled In #{@section.name}"
  end

  test "section sessions link" do
    visit site_section_url(@site, @section)
    assert_link "Sessions"
    click_on "Sessions"
    assert_selector "h4", text: "Sessions Administered For #{@section.name}"
  end

  test "should update Section" do
    visit site_section_url(@site, @section)
    click_on "Edit this section", match: :first

    select(@section.curriculum.title, from: "section_curriculum_id")
    fill_in "End date", with: @section.end_date.to_s
    fill_in "Name", with: @section.name
    fill_in "Start date", with: @section.start_date.to_s
    uncheck("section_completed")
    click_on "Update Section"

    assert_text "Section was successfully updated"
  end
end
