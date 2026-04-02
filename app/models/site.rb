# == Schema Information
#
# Table name: sites
# Database name: primary
#
#  id              :bigint           not null, primary key
#  code            :string           not null
#  county          :string
#  discarded_at    :datetime
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#
# Indexes
#
#  index_sites_on_code             (code) UNIQUE
#  index_sites_on_discarded_at     (discarded_at)
#  index_sites_on_organization_id  (organization_id)
#
class Site < ApplicationRecord
  include Discard::Model
  belongs_to :organization
  has_many :site_participants, dependent: :destroy
  has_many :participants, through: :site_participants
  has_many :sections, dependent: :destroy
  has_many :user_sites, dependent: :destroy
  has_many :users, through: :user_sites
  has_many :section_participants, through: :sections

  validates :name, presence: true
  before_create :assign_code

  delegate :state, :urbanicity, :setting, to: :organization

  def self.ransackable_attributes(auth_object = nil)
    %w[name code county] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    [ :organization, :participants ]
  end

  def facilitators
    a_users = Role.where(name: "admin").map(&:users).flatten.uniq
    f_users = UserRole.where(role: Role.where(name: "facilitator"), user: users).map(&:user).flatten.uniq
    (a_users + f_users).uniq
  end

  def observers
    Role.where(name: [ "admin", "observer" ]).map(&:users).flatten.uniq
  end

  def site_users
    (users.where(user_sites: { site_id: id }) + sections.map { |s| s.facilitators }.flatten.uniq).uniq
  end

  private
    def assign_code
      self.code = "#{self.name[0..2]}-#{self.county[0..2]}-#{Random.alphanumeric(3)}".upcase
    end
end
