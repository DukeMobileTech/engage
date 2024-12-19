# == Schema Information
#
# Table name: attendances
#
#  id             :integer          not null, primary key
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
#  participant_id  (participant_id => participants.id)
#  sitting_id      (sitting_id => sittings.id)
#
require "test_helper"

class AttendanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
