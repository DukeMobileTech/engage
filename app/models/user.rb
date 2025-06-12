# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE)
#  email_address   :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :user_sites, dependent: :destroy
  has_many :sites, through: :user_sites
  has_many :sections, through: :sites
  has_many :user_sittings, dependent: :destroy
  has_many :sittings, through: :user_sittings
  has_many :organizations, -> { distinct }, through: :sites

  after_create :add_default_role
  after_update :remove_redundant_roles, if: -> { user_roles.count > 1 }
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def display_name
    name.split(" ").first.capitalize
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def facilitator?
    roles.exists?(name: "facilitator")
  end

  def observer?
    roles.exists?(name: "observer")
  end

  alias_method :original_sites, :sites
  def sites
    return Site.all if admin?

    self.original_sites
  end

  private
    def add_default_role
      user_roles.create(role: Role.find_by(name: "viewer"))
    end

    def remove_redundant_roles
      user_roles.where(role: Role.find_by(name: "viewer")).destroy_all if user_roles.count > 1
    end
end
