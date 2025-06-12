# == Schema Information
#
# Table name: organizations
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  name         :string           not null
#  setting      :string
#  state        :string
#  urbanicity   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_organizations_on_discarded_at  (discarded_at)
#
class Organization < ApplicationRecord
  include Discard::Model
  has_many :sites

  def self.ransackable_attributes(auth_object = nil)
    %w[name setting state urbanicity] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    [ :sites ]
  end
end
