require "test_helper"

class SitePolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @viewer = users(:viewer)
    @facilitator = users(:facilitator)
    @observer = users(:observer)
    @site = sites(:one)
  end

  test "site policy permits admin to manage sites" do
    assert_permit @admin, @site, %i[index? show? new? create? edit? update? destroy?]
  end

  test "site policy permits viewer to view sites" do
    assert_permit(@viewer, @site, %i[index? show?])
    refute_permit(@viewer, @site, %i[new? create? edit? update? destroy?])
  end

  test "site policy permits facilitator to manage sites" do
    assert_permit(@facilitator, @site, %i[index? show?])
    refute_permit(@facilitator, @site, %i[new? create? edit? update? destroy?])
  end

  test "site policy permits observer to view sites" do
    assert_permit(@observer, @site, %i[index? show?])
    refute_permit(@observer, @site, %i[new? create? edit? update? destroy?])
  end
end
