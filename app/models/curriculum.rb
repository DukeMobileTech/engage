# == Schema Information
#
# Table name: curriculums
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Curriculum < ApplicationRecord
  has_many :lessons, dependent: :destroy
  validates :title, presence: true
end
