require "test_helper"

class SittingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sitting = sittings(:one)
  end

  test "should get index" do
    get sittings_url
    assert_response :success
  end

  test "should get new" do
    get new_sitting_url
    assert_response :success
  end

  test "should create sitting" do
    assert_difference("Sitting.count") do
      post sittings_url, params: { sitting: { done_on: @sitting.done_on, lesson_id: @sitting.lesson_id, section_id: @sitting.section_id } }
    end

    assert_redirected_to sitting_url(Sitting.last)
  end

  test "should show sitting" do
    get sitting_url(@sitting)
    assert_response :success
  end

  test "should get edit" do
    get edit_sitting_url(@sitting)
    assert_response :success
  end

  test "should update sitting" do
    patch sitting_url(@sitting), params: { sitting: { done_on: @sitting.done_on, lesson_id: @sitting.lesson_id, section_id: @sitting.section_id } }
    assert_redirected_to sitting_url(@sitting)
  end

  test "should destroy sitting" do
    assert_difference("Sitting.count", -1) do
      delete sitting_url(@sitting)
    end

    assert_redirected_to sittings_url
  end
end
