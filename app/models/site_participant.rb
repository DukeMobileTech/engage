
# == Schema Information
#
# Table name: site_participants
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  participant_id :integer          not null
#  site_id        :integer          not null
#
# Indexes
#
#  index_site_participants_on_participant_id  (participant_id)
#  index_site_participants_on_site_id         (site_id)
#
# Foreign Keys
#
#  participant_id  (participant_id => participants.id)
#  site_id         (site_id => sites.id)
#
class SiteParticipant < ApplicationRecord
  belongs_to :site
  belongs_to :participant

  def self.ransackable_attributes(auth_object = nil)
    %w[site_id participant_id] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    [ :site, :participant ]
  end
end
