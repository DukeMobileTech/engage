require "application_system_test_case"

class OrganizationsTest < ApplicationSystemTestCase
  setup do
    @organization = organizations(:one)
    sign_in
  end

  test "visiting the index" do
    visit organizations_url
    assert_selector "h3", text: "Organizations"
    assert_table "organizations"
    assert_link "New organization"
    click_on "New organization"
    assert_current_path new_organization_path
  end

  test "should create organization" do
    visit organizations_url
    click_on "New organization"

    fill_in "Name", with: @organization.name
    select(@organization.setting, from: "Setting")
    select(@organization.state, from: "State")
    select(@organization.urbanicity, from: "Urbanicity")
    click_on "Create Organization"

    assert_text "Organization was successfully created"
  end

  test "should show organization" do
    visit organization_url(@organization)
    assert_text @organization.name
    assert_text @organization.setting
    assert_text @organization.state
    assert_text @organization.urbanicity
    assert_link "Edit this organization"
    assert_link "Back to organizations"
  end

  test "should update organization" do
    visit organization_url(@organization)
    click_on "Edit this organization", match: :first

    fill_in "Name", with: @organization.name
    select(@organization.setting, from: "Setting")
    select(@organization.state, from: "State")
    select(@organization.urbanicity, from: "Urbanicity")
    click_on "Update Organization"

    assert_text "Organization was successfully updated"
  end
end
