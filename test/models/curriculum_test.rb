# == Schema Information
#
# Table name: curriculums
#
#  id            :bigint           not null, primary key
#  program_model :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class CurriculumTest < ActiveSupport::TestCase
  fixtures :curriculums

  def setup
    @curriculum = curriculums(:one)
  end

  test "should be valid with valid attributes" do
    assert @curriculum.valid?
  end

  test "should not be valid without a title" do
    @curriculum.title = nil
    assert_not @curriculum.valid?
  end
end
