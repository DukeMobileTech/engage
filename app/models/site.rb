# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  county     :string
#  name       :string
#  setting    :string
#  state      :string
#  urbanicity :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sites_on_code  (code) UNIQUE
#
class Site < ApplicationRecord
  has_many :site_participants, dependent: :destroy
  has_many :participants, through: :site_participants
  has_many :sections, dependent: :destroy

  validates :name, presence: true
  validates :county, presence: true
  validates :state, presence: true
  validates :setting, presence: true
  validates :urbanicity, presence: true

  before_create :assign_code

  private

  def assign_code
    self.code = "#{self.name[0..2]}-#{self.county[0..2]}-#{Random.alphanumeric(3)}".upcase
  end
end
