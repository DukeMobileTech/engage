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
class Attendance < ApplicationRecord
  belongs_to :participant
  belongs_to :sitting
end
