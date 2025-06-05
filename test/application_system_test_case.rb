require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["CAPYBARA_SERVER_PORT"]
    served_by host: "rails-app", port: ENV["CAPYBARA_SERVER_PORT"]
    if ENV["CAPYBARA_SERVER_PORT"]
      served_by host: "rails-app", port: ENV["CAPYBARA_SERVER_PORT"]

      driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ], options: {
        browser: :remote,
        url: "http://#{ENV["SELENIUM_HOST"]}:4444"
      }
    else
      driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
    end
  else
    if ENV["CAPYBARA_SERVER_PORT"]
      served_by host: "rails-app", port: ENV["CAPYBARA_SERVER_PORT"]

      driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ], options: {
        browser: :remote,
        url: "http://#{ENV["SELENIUM_HOST"]}:4444"
      }
    else
      driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
    end
  end

  def sign_in(user = nil)
    Rails.cache.clear
    user ||= users(:one)
    visit new_session_path
    fill_in :email_address, with: user.email_address
    fill_in :password, with: "Password1!"
    click_on "Sign In"
    assert_current_path root_path
  end
end
