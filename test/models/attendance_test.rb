# == Schema Information
#
# Table name: attendances
#
#  id             :bigint           not null, primary key
#  present        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  participant_id :integer          not null
#  sitting_id     :integer          not null
#
# Indexes
#
#  index_attendances_on_participant_id                 (participant_id)
#  index_attendances_on_sitting_id                     (sitting_id)
#  index_attendances_on_sitting_id_and_participant_id  (sitting_id,participant_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (participant_id => participants.id)
#  fk_rails_...  (sitting_id => sittings.id)
#
require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  fixtures :attendances, :participants, :sittings

  def setup
    @attendance = attendances(:one)
    @participant = participants(:one)
    @sitting = sittings(:one)
  end

  test "should be valid with valid attributes" do
    assert @attendance.valid?
  end

  test "should not be valid without a participant" do
    @attendance.participant = nil
    assert_not @attendance.valid?
  end

  test "should not be valid without a sitting" do
    @attendance.sitting = nil
    assert_not @attendance.valid?
  end

  test "should have a valid participant_id" do
    @attendance.save
    assert_equal @participant.id, @attendance.participant_id
  end

  test "should have a valid sitting_id" do
    @attendance.save
    assert_equal @sitting.id, @attendance.sitting_id
  end
end
