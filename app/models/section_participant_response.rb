# == Schema Information
#
# Table name: section_participant_responses
#
#  id                     :bigint           not null, primary key
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
#  fk_rails_...  (response_id => responses.id)
#  fk_rails_...  (section_participant_id => section_participants.id) ON DELETE => cascade
#
class SectionParticipantResponse < ApplicationRecord
  belongs_to :response
  belongs_to :section_participant
  has_one :participant, through: :section_participant
end
