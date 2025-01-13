# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :integer          not null
#
# Indexes
#
#  index_activities_on_lesson_id  (lesson_id)
#
# Foreign Keys
#
#  lesson_id  (lesson_id => lessons.id)
#
class Activity < ApplicationRecord
  belongs_to :lesson
  validates :name, presence: true
end
