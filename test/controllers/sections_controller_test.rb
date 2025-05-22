require "test_helper"

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
    @site = sites(:one)
    sign_in
  end

  test "should get index" do
    get site_sections_url(@site)
    assert_response :success
  end

  test "should get new" do
    get new_site_section_url(@site)
    assert_response :success
  end

  test "should create section" do
    assert_difference("Section.count") do
      post site_sections_url(@site), params: { section: { curriculum_id: @section.curriculum_id, end_date: @section.end_date, name: @section.name, site_id: @section.site_id, start_date: @section.start_date } }
    end

    assert_redirected_to site_sections_url(@site)
  end

  test "should show section" do
    get site_section_url(@site, @section)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_section_url(@site, @section)
    assert_response :success
  end

  test "should update section" do
    patch site_section_url(@site, @section),  params: { section: { curriculum_id: @section.curriculum_id, end_date: @section.end_date, name: @section.name, site_id: @section.site_id, start_date: @section.start_date, completed: false } }
    assert_redirected_to site_section_url(@site, @section)
  end

  test "should destroy section" do
    assert_difference("Section.count", -1) do
      delete site_section_url(@site, @section)
    end

    assert_redirected_to site_sections_url(@site)
  end
end
