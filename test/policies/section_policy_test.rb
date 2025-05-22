require "test_helper"

class SectionPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @viewer = users(:viewer)
    @facilitator = users(:facilitator)
    @observer = users(:observer)
    @section = sections(:one)
  end

  test "section policy permits admin to manage sections" do
    assert_permit @admin, @section, %i[index? show? new? create? edit? update? destroy? data_tracker?]
  end

  test "section policy permits viewer to view sections" do
    assert_permit(@viewer, @section, %i[index? show?])
    refute_permit(@viewer, @section, %i[new? create? edit? update? destroy? data_tracker?])
  end

  test "section policy permits facilitator to manage sections" do
    assert_permit(@facilitator, @section, %i[index? show?])
    refute_permit(@facilitator, @section, %i[new? create? edit? update? destroy? data_tracker?])
  end

  test "section policy permits observer to view sections" do
    assert_permit(@observer, @section, %i[index? show?])
    refute_permit(@observer, @section, %i[new? create? edit? update? destroy? data_tracker?])
  end
end
