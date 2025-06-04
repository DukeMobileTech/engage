require "application_system_test_case"

class SitesTest < ApplicationSystemTestCase
  setup do
    @organization = organizations(:one)
    @site = sites(:one)
    sign_in
  end

  test "visiting the index" do
    visit sites_url
    assert_selector "h3", text: "My Sites"
    assert_table "sites"
    assert_link "New site"
  end

  test "should create site" do
    visit sites_url(@organization)
    click_on "New site"

    fill_in "County", with: @site.county
    fill_in "Name", with: @site.name
    select(@organization.name, from: "site_organization_id")
    click_on "Create Site"

    assert_text "Site was successfully created"
  end

  test "should update site" do
    visit site_url(@site)
    click_on "Edit this site", match: :first

    fill_in "Code", with: @site.code
    fill_in "County", with: @site.county
    fill_in "Name", with: @site.name
    select(@organization.name, from: "site_organization_id")
    click_on "Update Site"

    assert_text "Site was successfully updated"
  end

  test "should show site" do
    visit site_url(@site)
    assert_text @site.name
    assert_text @site.county
    assert_text @site.organization.name
    assert_link "Edit this site"
  end

  test "should have sidebar and main content" do
    visit site_url(@site)
    assert_selector "div.sidebar" # div with class 'sidebar'
    assert_selector "main" # main content area
  end

  test "details link" do
    visit site_url(@site)
    assert_link "Details"
    click_on "Details"
    assert_selector "h4", text: "Site Details"
  end

  test "site participants link" do
    visit site_url(@site)
    assert_link "Site Participants"
    click_on "Site Participants"
    assert_selector "h4", text: "Site Participants"
  end

  test "site sections link" do
    visit site_url(@site)
    assert_link "Sections"
    click_on "Sections"
    assert_selector "h4", text: "Site Sections"
  end
end
