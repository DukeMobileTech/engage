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
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    roles.exists?(name: "admin")
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
end
