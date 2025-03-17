# == Schema Information
#
# Table name: sites
#
#  id              :integer          not null, primary key
#  code            :string           not null
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#
# Indexes
#
#  index_sites_on_code             (code) UNIQUE
#  index_sites_on_organization_id  (organization_id)
#
class Site < ApplicationRecord
  belongs_to :organization
  has_many :site_participants, dependent: :destroy
  has_many :participants, through: :site_participants
  has_many :sections, dependent: :destroy
  has_many :user_sites, dependent: :destroy
  has_many :users, through: :user_sites

  validates :name, presence: true
  before_create :assign_code

  delegate :state, :county, :urbanicity, :setting, to: :organization

  def facilitators
    froles = Role.where(name: [ "admin", "facilitator" ])
    UserRole.where(role: froles, user: users).map(&:user)
  end

  def observers
    Role.where(name: [ "admin", "observer" ]).map(&:users).flatten
  end

  private

  def assign_code
    self.code = "#{self.name[0..2]}-#{self.county[0..2]}-#{Random.alphanumeric(3)}".upcase
  end
end
