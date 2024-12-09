# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  category   :string           default("Youth")
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  study_id   :string
#
# Indexes
#
#  index_participants_on_study_id  (study_id) UNIQUE
#
class Participant < ApplicationRecord
  has_many :site_participants
  has_many :sites, through: :site_participants
  has_many :attendances

  validates :name, presence: true
  validates :category, presence: true

  before_create :assign_study_id

  def upcased_name
    self.name.split(" ").map(&:upcase_first).join(" ")
  end

  private

  def assign_study_id
    self.study_id = "#{self.name[0..2]}-#{Date.current.year}-#{Random.alphanumeric(3)}".upcase
  end
end
