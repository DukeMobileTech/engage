# == Schema Information
#
# Table name: section_participants
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  participant_id :integer          not null
#  section_id     :integer          not null
#
# Indexes
#
#  index_section_participants_on_participant_id  (participant_id)
#  index_section_participants_on_section_id      (section_id)
#
# Foreign Keys
#
#  participant_id  (participant_id => participants.id)
#  section_id      (section_id => sections.id)
#
class SectionParticipant < ApplicationRecord
  belongs_to :section
  belongs_to :participant
end
