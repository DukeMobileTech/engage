require "test_helper"

class OrganizationPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @viewer = users(:viewer)
    @facilitator = users(:facilitator)
    @observer = users(:observer)
    @organization = organizations(:one)
  end

  test "organization policy permits admin to manage organizations" do
    assert_permit @admin, @organization, %i[index? show? new? create? edit? update? destroy?]
  end

  test "organization policy permits viewer to view organizations" do
    assert_permit(@viewer, @organization, %i[index? show?])
    refute_permit(@viewer, @organization, %i[new? create? edit? update? destroy?])
  end

  test "organization policy permits facilitator to manage organizations" do
    assert_permit(@facilitator, @organization, %i[index? show?])
    refute_permit(@facilitator, @organization, %i[new? create? edit? update? destroy?])
  end

  test "organization policy permits observer to view organizations" do
    assert_permit(@observer, @organization, %i[index? show?])
    refute_permit(@observer, @organization, %i[new? create? edit? update? destroy?])
  end
end
