# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  setting    :string
#  state      :string
#  urbanicity :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  has_many :sites

  def self.ransackable_attributes(auth_object = nil)
    %w[name setting state urbanicity] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    [ :sites ]
  end
end
