require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do
    Rails.cache.clear
    @user = users(:one)
  end

  test "visiting the sign in page" do
    visit new_session_path
    assert_selector "h1", text: "Please sign in"
  end

  test "signing in with valid credentials" do
    visit new_session_path
    fill_in :email_address, with: @user.email_address
    fill_in :password, with: "Password1!"
    click_on "Sign In"

    assert_selector "h3", text: "My Sites"
  end

  test "signing in with invalid credentials" do
    visit new_session_path
    fill_in :email_address, with: @user.email_address
    fill_in :password, with: "WrongPassword"
    click_on "Sign In"

    assert_text "Try another email address or password."
  end

  test "signing out" do
    visit new_session_path
    fill_in :email_address, with: @user.email_address
    fill_in :password, with: "Password1!"
    click_on "Sign In"

    assert_selector "h3", text: "My Sites"

    visit profile_user_path(@user)
    click_on "Sign Out"

    assert_selector "h1", text: "Please sign in"
  end

  test "rate limiting sign in attempts" do
    11.times do
      visit new_session_path
      fill_in :email_address, with: @user.email_address
      fill_in :password, with: "WrongPassword"
      click_on "Sign In"
    end

    assert_text "Try again later."
  end

  test "forgot password link" do
    visit new_session_path

    assert_link "Forgot password?"

    click_on "Forgot password?"

    assert_selector "h1", text: "Forgot your password?"
  end
end
