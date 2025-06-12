require "test_helper"

class SittingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sitting = sittings(:one)
    @section = sections(:one)
    @site = sites(:one)
    @lessons = @section.lessons
    @facilitators = @site.facilitators
    sign_in
  end

  test "should get index" do
    get site_section_sittings_url(@site, @section)
    assert_response :success
  end

  test "should get new" do
    get new_site_section_sitting_url(@site, @section)
    assert_response :success
  end

  test "should create sitting" do
    assert_difference("Sitting.count") do
      post site_section_sittings_url(@site, @section), params: { sitting: { done_on: @sitting.done_on, section_id: @section.id, name: @sitting.name, completed: @sitting.completed } }
    end

    assert_redirected_to site_section_sitting_url(@site, @section, Sitting.last)
  end

  test "should show sitting" do
    get site_section_sitting_url(@site, @section, @sitting)
    assert_response :success
  end

  test "should get edit" do
    get edit_site_section_sitting_url(@site, @section, @sitting)
    assert_response :success
  end

  test "should update sitting" do
    patch site_section_sitting_url(@site, @section, @sitting), params: { sitting: { done_on: @sitting.done_on, section_id: @section.id, name: @sitting.name, completed: @sitting.completed } }
    assert_redirected_to site_section_sitting_url(@site, @section, @sitting)
  end

  test "should destroy sitting" do
    assert_difference("Sitting.kept.count", -1) do
      delete site_section_sitting_url(@site, @section, @sitting)
    end

    assert_redirected_to site_section_sittings_url(@site, @section)
  end
end
