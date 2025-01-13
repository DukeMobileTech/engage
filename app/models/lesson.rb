# == Schema Information
#
# Table name: lessons
#
#  id            :integer          not null, primary key
#  content       :text
#  duration      :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  curriculum_id :integer          not null
#
# Indexes
#
#  index_lessons_on_curriculum_id  (curriculum_id)
#
# Foreign Keys
#
#  curriculum_id  (curriculum_id => curriculums.id)
#
class Lesson < ApplicationRecord
  belongs_to :curriculum
  has_many :activities, dependent: :destroy, inverse_of: :lesson, autosave: true
  accepts_nested_attributes_for :activities, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true
  validates :content, presence: true
  validates :duration, presence: true
end
