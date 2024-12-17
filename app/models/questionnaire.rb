# == Schema Information
#
# Table name: questionnaires
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Questionnaire < ApplicationRecord
  has_many :questions, dependent: :destroy, inverse_of: :questionnaire
  has_many :responses, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
end
