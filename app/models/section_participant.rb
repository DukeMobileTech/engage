# == Schema Information
#
# Table name: section_participants
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  participant_id :integer          not null
#  section_id     :integer          not null
#
# Indexes
#
#  index_section_participants_on_participant_id  (participant_id)
#  index_section_participants_on_section_id      (section_id)
#
# Foreign Keys
#
#  fk_rails_...  (participant_id => participants.id)
#  fk_rails_...  (section_id => sections.id)
#
class SectionParticipant < ApplicationRecord
  belongs_to :section
  belongs_to :participant
  has_many :responses, through: :participant
  has_one :section_participant_response, dependent: :destroy
  has_many :lesson_attendances, through: :participant

  def self.ransackable_attributes(auth_object = nil)
    %w[participant_id] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    [ :participant ]
  end

  def section_lesson_attendances
    lesson_attendances.joins(:sitting_lesson).where(sitting_lessons: { sitting_id: section.sittings.kept.pluck(:id) }).order("sitting_lessons.sitting_id ASC, sitting_lessons.lesson_id ASC")
  end

  def unique_lesson_attendances
    completed_sittings_ids = section.sittings.kept.where(completed: true).pluck(:id)
    sitting_lesson_ids = section.sitting_lessons.where(sitting_id: completed_sittings_ids).pluck(:id)
    return lesson_attendances.none if sitting_lesson_ids.empty?

    lesson_attendances
      .joins(:sitting_lesson)
      .where(sitting_lesson_id: sitting_lesson_ids, present: true)
      .select("DISTINCT ON (sitting_lessons.lesson_id) lesson_attendances.*")
      .order("sitting_lessons.lesson_id, lesson_attendances.created_at DESC")
  end

  def average_attendance
    ((unique_lesson_attendances.size / section.lessons_covered.to_f) * 100).round(2)
  end

  def attendance_str
    "#{unique_lesson_attendances.size} out of #{section.lessons_covered}"
  end

  def progress
    average_attendance
  end

  def cumulative_average_attendance
    completed_sittings_ids = section.sittings.kept.where(completed: true).pluck(:id)
    completed_lesson_count = section.sitting_lessons.where(sitting_id: completed_sittings_ids).pluck(:lesson_id).uniq.size
    return 0 if completed_lesson_count.zero?
    ((unique_lesson_attendances.size / completed_lesson_count.to_f) * 100).round(2)
  end

  def demographics_response
    section_participant_response&.response
  end

  def demographics_responses
    participant.demographics_responses
  end

  def demographics_label
    demographics_response&.demographics_label
  end

  def demographics_questionnaire
    Questionnaire.find_by(title: "demographics")
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
end
