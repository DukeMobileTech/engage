# == Schema Information
#
# Table name: section_participant_responses
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  response_id            :integer          not null
#  section_participant_id :integer          not null
#
# Indexes
#
#  index_section_participant_responses_on_response_id             (response_id)
#  index_section_participant_responses_on_section_participant_id  (section_participant_id)
#
# Foreign Keys
#
#  response_id             (response_id => responses.id)
#  section_participant_id  (section_participant_id => section_participants.id)
#
class SectionParticipantResponse < ApplicationRecord
  belongs_to :response
  belongs_to :section_participant
  has_one :participant, through: :section_participant
end
