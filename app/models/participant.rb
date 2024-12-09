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
  has_many :section_participants
  has_many :sections, through: :section_participants
  has_many :attendances
  has_many :sessions, through: :attendances

  validates :name, presence: true
  validates :category, presence: true

  before_create :assign_study_id

  def upcased_name
    self.name.split(" ").map(&:upcase_first).join(" ")
  end

  def session_attendances(section)
    section_participant(section)&.session_attendances
  end

  def attendance_str(section)
    section_participant(section)&.attendance_str
  end

  def section_participant(section)
    section_participants.find_by(section_id: section.id)
  end

  private

  def assign_study_id
    self.study_id = "#{self.name[0..2]}-#{Date.current.year}-#{Random.alphanumeric(3)}".upcase
  end
end
