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
  has_many :lessons, dependent: :destroy, inverse_of: :curriculum, autosave: true
  has_many :sections
  validates :title, presence: true

  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  def sites
    sections.map(&:site).uniq
  end
end
