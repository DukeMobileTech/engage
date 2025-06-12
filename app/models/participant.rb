# == Schema Information
#
# Table name: participants
#
#  id           :bigint           not null, primary key
#  category     :string           default("Youth")
#  discarded_at :datetime
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  study_id     :string
#
# Indexes
#
#  index_participants_on_discarded_at  (discarded_at)
#  index_participants_on_study_id      (study_id) UNIQUE
#
class Participant < ApplicationRecord
  include Discard::Model
  has_many :site_participants, dependent: :destroy
  has_many :sites, through: :site_participants
  has_many :section_participants, dependent: :destroy
  has_many :sections, through: :section_participants
  has_many :attendances, dependent: :destroy
  has_many :sittings, through: :attendances
  has_many :responses, dependent: :nullify

  validates :name, presence: true
  validates :category, presence: true

  before_create :assign_study_id

  def self.ransackable_attributes(auth_object = nil)
    %w[name study_id category] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def upcased_name
    self.name.split(" ").map(&:upcase_first).join(" ")
  end

  def demo_label
    "#{category} #{sex} #{age}".strip
  end

  def enroll_label
    if demographics_response
      "#{self.upcased_name} (#{self.demo_label})"
    else
      "#{self.upcased_name} (#{self.category})"
    end
  end

  def average_attendance(section)
    att = sitting_attendances(section).size
    sit = section.sittings.size
    return 0 if att == 0 || sit == 0

    (att.to_f / sit.to_f).round * 100
  end

  def sitting_attendances(section)
    section_participant(section)&.sitting_attendances
  end

  def attendance_str(section)
    section_participant(section)&.attendance_str
  end

  def section_participant(section)
    section_participants.find_by(section_id: section.id)
  end

  def demographics_questionnaire
    Questionnaire.find_by(title: "demographics")
  end

  def demographics_responses
    responses.kept.where(questionnaire_id: demographics_questionnaire&.id)
  end

  def demographics_response
    responses.kept.order(created_at: :desc).find_by(questionnaire_id: demographics_questionnaire&.id)
  end

  def single_choice_answer(identifier)
    return nil unless demographics_response

    question = demographics_questionnaire.questions.find_by(identifier: identifier)
    return nil unless question

    question.answers.find { |a| a.id.to_s == demographics_response.answers[question.id.to_s] }&.text
  end

  def multiple_choice_answer(identifier)
    return nil unless demographics_response

    question = demographics_questionnaire.questions.find_by(identifier: identifier)
    return nil unless question

    answers = demographics_response.multiple_choice_answers(question.id)
    return nil if answers.empty?

    answers.map { |a| question.answers.find { |ans| ans.id.to_s == a.to_s }&.text }.compact.join(", ")
  end

  def sex
    single_choice_answer("sex")
  end

  def grade
    single_choice_answer("grade")
  end

  def gender
    single_choice_answer("gender")
  end

  def orientation
    single_choice_answer("orientation")
  end

  def age
    single_choice_answer("age")
  end

  def race
    multiple_choice_answer("race")
  end

  def ethnicity
    single_choice_answer("ethnicity")
  end

  def race_ethnicity
    rac = race || "Not Reported"
    eth = ethnicity || "Not Reported"
    "#{rac} / #{eth}"
  end

  private

  def assign_study_id
    self.study_id = loop do
      sid = "#{self.name[0..2]}-#{Date.current.year}-#{Random.alphanumeric(3)}".upcase
      break sid unless Participant.exists?(study_id: sid)
    end
  end
end
