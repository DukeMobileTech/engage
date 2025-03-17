# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  county     :string
#  name       :string           not null
#  setting    :string
#  state      :string
#  urbanicity :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  has_many :sites
end
