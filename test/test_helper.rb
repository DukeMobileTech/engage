ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActionDispatch
  class IntegrationTest
    def sign_in
      Rails.cache.clear
      user = users(:one)
      post session_url(email_address: user.email_address, password: "Password1!")
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def assert_permit(user, record, actions)
      actions = Array(actions)

      actions.each do |action|
        msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
        assert Pundit.policy!(user, record).public_send(action), msg
      end
    end

    def refute_permit(user, record, actions)
      actions = Array(actions)

      actions.each do |action|
        msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
        refute Pundit.policy!(user, record).public_send(action), msg
      end
    end
  end
end
