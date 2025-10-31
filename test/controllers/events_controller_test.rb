require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = responses(:four)
    sign_in
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get show" do
    get event_url(@event)
    assert_response :success
  end

  test "should get destroy" do
    assert_difference("Response.kept.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
