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

  def activity_question
    questions.find_by(identifier: "activities")
  end

  def delivery_modified_question
    questions.find_by(identifier: "delivery-modified-follow-up")
  end

  def content_modified_question
    questions.find_by(identifier: "content-modified-follow-up")
  end

  def not_delivered_question
    questions.find_by(identifier: "not-delivered-follow-up")
  end

  def self.observation
    find_by(title: "program observation")
  end

  def observation?
    title == "program observation"
  end

  def evaluation?
    title == "fidelity monitoring"
  end

  def demographics?
    title == "demographics"
  end
end
