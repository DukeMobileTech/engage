require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @viewer = users(:viewer)
    @facilitator = users(:facilitator)
    @observer = users(:observer)
  end

  test "user policy permits admin to manage users" do
    assert_permit @admin, User, :index?
    assert_permit @admin, User, :show?
    assert_permit @admin, User, :new?
    assert_permit @admin, User, :create?
    assert_permit @admin, User, :edit?
    assert_permit @admin, User, :update?
    assert_permit @admin, User, :destroy?
  end

  test "user policy permits viewer to view users" do
    assert_permit @viewer, User, :index?
    assert_permit @viewer, User, :show?
    refute_permit @viewer, User, :new?
    refute_permit @viewer, User, :create?
    refute_permit @viewer, User, :edit?
    refute_permit @viewer, User, :update?
    refute_permit @viewer, User, :destroy?
  end

  test "user policy permits facilitator to manage users" do
    assert_permit @facilitator, User, :index?
    assert_permit @facilitator, User, :show?
    refute_permit @facilitator, User, :new?
    refute_permit @facilitator, User, :create?
    refute_permit @facilitator, User, :edit?
    refute_permit @facilitator, User, :update?
    refute_permit @facilitator, User, :destroy?
  end

  test "user policy permits observer to view users" do
    assert_permit @observer, User, :index?
    assert_permit @observer, User, :show?
    refute_permit @observer, User, :new?
    refute_permit @observer, User, :create?
    refute_permit @observer, User, :edit?
    refute_permit @observer, User, :update?
    refute_permit @observer, User, :destroy?
  end
end
