# == Schema Information
#
# Table name: sections
#
#  id            :integer          not null, primary key
#  completed     :boolean          default(FALSE)
#  end_date      :date
#  name          :string
#  start_date    :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  curriculum_id :integer          not null
#  site_id       :integer          not null
#
# Indexes
#
#  index_sections_on_curriculum_id  (curriculum_id)
#  index_sections_on_site_id        (site_id)
#
# Foreign Keys
#
#  curriculum_id  (curriculum_id => curriculums.id)
#  site_id        (site_id => sites.id)
#
class Section < ApplicationRecord
  belongs_to :curriculum
  belongs_to :site
  has_many :section_participants
  has_many :participants, through: :section_participants
  has_many :sittings
  has_many :lessons, through: :curriculum

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def progress
    "#{sittings.where(completed: true).pluck(:lesson_id).uniq.count} / #{lessons.count}"
  end
end
