# == Schema Information
#
# Table name: activities
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :integer          not null
#
# Indexes
#
#  index_activities_on_lesson_id  (lesson_id)
#
# Foreign Keys
#
#  fk_rails_...  (lesson_id => lessons.id)
#
require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  fixtures :lessons, :activities

  def setup
    @lesson = lessons(:one)
    @activity = activities(:one)
  end

  test "should be valid with valid attributes" do
    assert @activity.valid?
  end

  test "should not be valid without a name" do
    @activity.name = nil
    assert_not @activity.valid?
  end

  test "should not be valid without a lesson" do
    @activity.lesson = nil
    assert_not @activity.valid?
  end

  test "should have a valid lesson_id" do
    @activity.save
    assert_equal @lesson.id, @activity.lesson_id
  end
end
