# == Schema Information
#
# Table name: sections
#
#  id            :bigint           not null, primary key
#  completed     :boolean          default(FALSE)
#  discarded_at  :datetime
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
#  index_sections_on_discarded_at   (discarded_at)
#  index_sections_on_site_id        (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (curriculum_id => curriculums.id)
#  fk_rails_...  (site_id => sites.id)
#
class Section < ApplicationRecord
  include Discard::Model
  has_many_attached :reports
  belongs_to :curriculum
  belongs_to :site
  has_many :section_participants, dependent: :destroy
  has_many :participants, through: :section_participants
  has_many :section_participant_responses, through: :section_participants
  has_many :sittings, dependent: :destroy
  has_many :lessons, through: :curriculum
  has_many :lesson_attendances, through: :sittings
  has_many :sitting_lessons, through: :sittings

  before_create :assign_name

  validates :curriculum_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :completed_only_if_all_sittings_completed

  scope :completed, -> { where(completed: true) }

  def completed_sittings
    sittings.kept.where(completed: true)
  end

  def progress_label
    "#{completed_sittings.map(&:sitting_lessons).flatten.pluck(:lesson_id).uniq.count} / #{lessons.count} lessons entered"
  end

  def progress_percentage
    return 0 if lessons.count.zero?
    (completed_sittings.map(&:sitting_lessons).flatten.pluck(:lesson_id).uniq.count.to_f / lessons.count * 100).round(2)
  end

  def progress_simple
    "#{completed_sittings.map(&:sitting_lessons).flatten.pluck(:lesson_id).uniq.count} / #{lessons.count}"
  end

  def progress_radius
    45
  end

  def progress_circumference
    2 * Math::PI * progress_radius
  end

  def progress_offset
    progress = progress_percentage.to_f.clamp(0, 100)
    progress_circumference * (1 - progress / 100.0)
  end

  def average_attendance_status
    avg = average_attendance
    if avg >= 75
      "good"
    elsif avg < 50
      "poor"
    else
      "warning"
    end
  end

  def lesson_progress_status
    lessons_done = completed_sittings.map(&:sitting_lessons).flatten.pluck(:lesson_id).uniq.count
    if lessons_done >= 0.67 * lessons.count
      "final"
    elsif lessons_done > 0.33 * lessons.count
      "middle"
    else
      "first"
    end
  end

  def generate_data_tracker
    tempfile = Tempfile.new(Time.now.to_i.to_s)
    tabs = [ "Attendance", "Observations", "Reporting Data- Reach", "Reporting Data- Dosage", "Reporting Data- Fidelity" ]
    Axlsx::Package.new do |p|
      workbook = p.workbook
      tabs.each do |tab|
        add_sheet(workbook, tab)
      end
      p.serialize(tempfile.path)
    end
    reports.attach(io: File.open(tempfile.path),
                   filename: "#{name} Data Tracker (#{DateTime.now.strftime("%F %H:%M %p")}).xlsx",
                   content_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                  )
  end

  def add_sheet(workbook, tab)
    workbook.add_worksheet(name: tab) do |sheet|
      case tab
      when "Attendance"
        add_attendance_sheet(sheet)
      when "Observations"
        add_observations_sheet(sheet)
      when "Reporting Data- Reach"
        add_reporting_data_reach_sheet(sheet)
      when "Reporting Data- Dosage"
        add_reporting_data_dosage_sheet(sheet)
      when "Reporting Data- Fidelity"
        add_reporting_data_fidelity_sheet(sheet)
      end
    end
  end

  def attendance(sessions, participant)
    roster = []
    sessions.each do |session|
      attendance = participant.lesson_attendances
                              .where(sitting_lesson_id: session.sitting_lessons.pluck(:id))
                              .where(present: true).first
      roster << attendance.nil? ? "0" : "1"
    end
    roster
  end

  def add_attendance_sheet(sheet)
    demo = [ "ParticipantID", "Type", "Race/Ethnicity", "Sex", "Gender Indentity",
             "Sexual Orientation", "Age", "Grade" ]
    auto = [ "Reach", "Attendance" ]
    sessions = sittings.kept.order(:done_on)
    sheet.add_row demo + auto + sessions.pluck(:name)
    section_participants.each do |sp|
      att_list = attendance(sessions, sp.participant)
      reach = att_list.include?("1") ? "1" : "0"
      progress = ((att_list.count("1") / att_list.count.to_f) * 100).round
      sheet.add_row [ sp.participant.study_id, sp.participant.category, sp.race_ethnicity,
                      sp.sex, sp.gender, sp.orientation, sp.age, sp.grade ] + [ reach, "#{progress}%" ] + att_list
    end
  end

  def observation_form
    Questionnaire.observation
  end

  def observations
    Response.kept.where(questionnaire_id: observation_form&.id, sitting_id: sittings.kept.pluck(:id)).order(created_at: :desc)
  end

  def quality_question
    observation_form.questions.find_by(identifier: "quality")
  end

  def activities_planned_question
    observation_form.questions.find_by(identifier: "activities-planned")
  end

  def activities_completed_question
    observation_form.questions.find_by(identifier: "activities-completed")
  end

  def sitting_quality_adherence(obs)
    activities_planned = activities_planned_question&.question_answer(obs)&.to_i
    activities_completed = activities_completed_question&.question_answer(obs)&.to_i
    adh = 0 if activities_planned.zero?
    adh = (activities_completed / activities_planned.to_f) * 100 if activities_planned.positive?
    qual = quality_question&.question_answer(obs)
    [ obs.sitting, qual, activities_planned, activities_completed, adh ]
  end

  def add_observations_sheet(sheet)
    sheet.add_row [ "Observation Date", "Session#", "Q7. Overall Quality",
                    "Activities Planned", "Activities Completed", "Session Adherence" ]
    observations.each do |obs|
      sitting, quality, activity_count, complete_count, adh = sitting_quality_adherence(obs)
      sheet.add_row [ sitting&.done_on, sitting&.name, quality, activity_count, complete_count, "#{adh}%" ]
    end
  end

  def race_ethnicity_counts(participant_list, race)
    group = participant_list.select { |p| p.race == race }
    hispanic = group.select { |g| g.ethnicity == "Hispanic or Latino/a" }
    non_hispanic = group.select { |g| g.ethnicity == "Not Hispanic or Latino/a" }
    [ group.size, hispanic.size, non_hispanic.size ]
  end

  def add_reporting_data_reach_sheet(sheet)
    # total
    youth_p = participants.where(category: "Youth")
    sheet.add_row [ "Total Participant Reach", participants.size ]
    sheet.add_row [ "Youth", youth_p.size ]
    sheet.add_row [ "Caregiver", participants.where(category: "Caregiver").size ]
    sheet.add_row [ "Youth Serving Professional", participants.where(category: "Youth Serving Professional").size ]
    sheet.add_row []
    # sex
    youth = section_participants.where(participant_id: youth_p.pluck(:id))
    sexes = youth.map { |p| p.sex }
    sheet.add_row [ "Reach by Sex", "Participants" ]
    sheet.add_row [ "Male", sexes.count("Male") ]
    sheet.add_row [ "Female", sexes.count("Female") ]
    sheet.add_row [ "Not Reported", sexes.count("Not Reported") + sexes.count(nil) + sexes.count("Prefer not to say") ]
    sheet.add_row [ "Total", youth.size ]
    sheet.add_row []
    # Youth race/ethnicity
    reach_by_race_ethnicity(sheet, "Youth")
    # Caregiver race/ethnicity
    reach_by_race_ethnicity(sheet, "Caregiver")
    # Youth Serving Professional
    reach_by_race_ethnicity(sheet, "Youth Serving Professional")
    # gender identity
    sheet.add_row [ "Reach by Gender Identity", "Participants" ]
    groups = youth.group_by { |p| p.gender }
    sheet.add_row [ "Male", groups["Male"]&.size || 0 ]
    sheet.add_row [ "Female", groups["Female"]&.size  || 0 ]
    sheet.add_row [ "Transgender Male", groups["Transgender Female To Male"]&.size || 0 ]
    sheet.add_row [ "Transgender Female", groups["Transgender Male To Female"]&.size || 0 ]
    sheet.add_row [ "Non-binary Person", groups["Non-binary"]&.size || 0 ]
    sheet.add_row [ "Something Else", groups["Something Else"]&.size || 0 ]
    sheet.add_row [ "Not Reported", (groups["Not Reported"]&.size || 0) + (groups[nil]&.size || 0) ]
    sheet.add_row [ "Total", youth.size ]
    sheet.add_row []
    # sexual orientation
    sheet.add_row [ "Reach by Sexual Orientation", "Participants" ]
    orientations = youth.group_by { |p| p.orientation }
    sheet.add_row [ "Straight or heterosexual", orientations["Heterosexual"]&.size || 0 ]
    sheet.add_row [ "Bisexual", orientations["Bisexual"]&.size || 0 ]
    sheet.add_row [ "Lesbian, gay, or homosexual", orientations["Homosexual"]&.size || 0 ]
    sheet.add_row [ "Something Else", orientations["Something Else"]&.size || 0 ]
    sheet.add_row [ "Have not Decided", orientations["Not Decided"]&.size || 0 ]
    sheet.add_row [ "Not Reported", (orientations["Not Reported"]&.size || 0) + (orientations[nil]&.size || 0) ]
    sheet.add_row [ "Total", youth.size ]
    sheet.add_row []
    # age
    sheet.add_row [ "Reach by Age", "Participants" ]
    ages = youth.group_by { |p| p.age }
    sheet.add_row [ "10 or younger", ages["10 yrs old or younger"]&.size || 0 ]
    sheet.add_row [ "11", ages["11 yrs"]&.size || 0 ]
    sheet.add_row [ "12", ages["12 yrs"]&.size || 0 ]
    sheet.add_row [ "13", ages["13 yrs"]&.size || 0 ]
    sheet.add_row [ "14", ages["14 yrs"]&.size || 0 ]
    sheet.add_row [ "15", ages["15 yrs"]&.size || 0 ]
    sheet.add_row [ "16", ages["16 yrs"]&.size || 0 ]
    sheet.add_row [ "17", ages["17 yrs"]&.size || 0 ]
    sheet.add_row [ "18", ages["18 yrs"]&.size || 0 ]
    sheet.add_row [ "19", ages["19 yrs"]&.size || 0 ]
    sheet.add_row [ "20 or older", ages["20 yrs or older"]&.size || 0 ]
    sheet.add_row [ "Not reported", (ages["Not Reported"]&.size || 0) + (ages[nil]&.size || 0) ]
    sheet.add_row [ "Total", youth.size ]
    sheet.add_row []
    # grade
    sheet.add_row [ "Reach by Grade", "Participants" ]
    grades = youth.group_by { |p| p.grade }
    sheet.add_row [ "6th grade or less", grades["6th or less"]&.size || 0 ]
    sheet.add_row [ "7th grade", grades["7th"]&.size || 0 ]
    sheet.add_row [ "8th grade", grades["8th"]&.size || 0 ]
    sheet.add_row [ "9th grade", grades["9th"]&.size || 0 ]
    sheet.add_row [ "10th grade", grades["10th"]&.size || 0 ]
    sheet.add_row [ "11th grade", grades["11th"]&.size || 0 ]
    sheet.add_row [ "12th grade", grades["12th"]&.size || 0 ]
    sheet.add_row [ "GED", grades["GED"]&.size || 0 ]
    sheet.add_row [ "Technical/Vocational Training/College", grades["Technical/Vocational Training/College"]&.size || 0 ]
    sheet.add_row [ "Ungraded", grades["Ungraded"]&.size || 0 ]
    sheet.add_row [ "Not in School", grades["Not in School"]&.size || 0 ]
    sheet.add_row [ "Not reported", (grades["Not Reported"]&.size || 0) + (grades[nil]&.size || 0) ]
    sheet.add_row [ "Total", youth.size ]
    sheet.add_row []
  end

  def reach_by_race_ethnicity(sheet, category)
    c_participants = participants.where(category: category)
    participant_list = section_participants.where(participant_id: c_participants.pluck(:id))
    sheet.add_row [ "", "", "#{category} Reach by Race/Ethnicity", "" ]
    sheet.add_row [ category, "Hispanic/Latino", "Non-Hispanic/Latino", "Uknown Ethnicity" ]
    white, white_hispanic, white_non_hispanic = race_ethnicity_counts(participant_list, "White")
    sheet.add_row [ "White", white_hispanic, white_non_hispanic, white - white_hispanic - white_non_hispanic ]
    black, black_hispanic, black_non_hispanic = race_ethnicity_counts(participant_list, "Black or African American")
    sheet.add_row [ "Black", black_hispanic, black_non_hispanic, black - black_hispanic - black_non_hispanic ]
    asian, asian_hispanic, asian_non_hispanic = race_ethnicity_counts(participant_list, "Asian")
    sheet.add_row [ "Asian", asian_hispanic, asian_non_hispanic, asian - asian_hispanic - asian_non_hispanic ]
    native, native_hispanic, native_non_hispanic = race_ethnicity_counts(participant_list, "American Indian or Alaska Native")
    sheet.add_row [ "Native American/Alaska Native", native_hispanic, native_non_hispanic, native - native_hispanic - native_non_hispanic ]
    islander, islander_hispanic, islander_non_hispanic = race_ethnicity_counts(participant_list, "Native Hawaiian or Other Pacific Islander")
    sheet.add_row [ "Native Hawaiian/Other Pacific Islander", islander_hispanic, islander_non_hispanic, islander - islander_hispanic - islander_non_hispanic ]
    multiple = participant_list.select { |p| p.race&.include?(",") || p.race == "More than one race" }
    m_hispanic = multiple.select { |m| m.ethnicity == "Hispanic or Latino/a" }
    m_non_hispanic = multiple.select { |m| m.ethnicity == "Not Hispanic or Latino/a" }
    sheet.add_row [ "More than One", m_hispanic.size, m_non_hispanic.size, multiple.size - m_hispanic.size - m_non_hispanic.size ]
    unreported = participant_list.select { |p| (p.race == "Not Reported" || p.race.blank?) }
    u_hispanic = unreported.select { |u| u.ethnicity == "Hispanic or Latino/a" }
    u_non_hispanic = unreported.select { |u| u.ethnicity == "Not Hispanic or Latino/a" }
    sheet.add_row [ "Not Reported", u_hispanic.size, u_non_hispanic.size, unreported.size - u_hispanic.size - u_non_hispanic.size ]
    hispanic_total = white_hispanic + black_hispanic + asian_hispanic + native_hispanic + islander_hispanic + m_hispanic.size + u_hispanic.size
    non_hispanic_total = white_non_hispanic + black_non_hispanic + asian_non_hispanic + native_non_hispanic + islander_non_hispanic + m_non_hispanic.size + u_non_hispanic.size
    sheet.add_row [ "Total", hispanic_total, non_hispanic_total, participant_list.size - hispanic_total - non_hispanic_total ]
    sheet.add_row []
  end

  def average_attendance
    sum = completed_sittings.map { |sitting| sitting.average_attendance }.sum
    completed_sittings.size.positive? ? (sum / completed_sittings.size).round(2) : 0
  end

  def add_reporting_data_dosage_sheet(sheet)
    attendance_list = participants.map { |p| p.average_attendance(self) }
    sheet.add_row [ "Dosage", "" ]
    sheet.add_row [ "Average Attendance %", average_attendance ]
    sheet.add_row [ "Number of Participants >= 75% Attendance", attendance_list.select { |a| a >= 75 }.size ]
    sheet.add_row []
  end

  def add_reporting_data_fidelity_sheet(sheet)
    adh_list = []
    qual_list = []
    observations.each do |obs|
      _sitting, quality, _activity_count, _complete_count, adh = sitting_quality_adherence(obs)
      adh_list << adh
      qual_list << quality&.to_i
    end
    avg_adh = (adh_list.sum / adh_list.size).round if adh_list.size.positive?
    avg_adh = 0 if adh_list.size.zero?
    avg_qual = (qual_list.sum / qual_list.size).round if qual_list.size.positive?
    avg_qual = 0 if qual_list.size.zero?

    sheet.add_row [ "Fidelity" ]
    sheet.add_row []
    sheet.add_row [ "Sessions" ]
    sheet.add_row [ "Sessions Planned", sittings.kept.size ]
    sheet.add_row [ "Sessions Completed", sittings.kept.where(completed: true).size ]
    sheet.add_row []
    sheet.add_row [ "Observed Fidelity" ]
    sheet.add_row [ "How many classes were observed?", observations&.size || 0 ]
    sheet.add_row [ "Average Observed Session Adherence", avg_adh ]
    sheet.add_row []
    sheet.add_row []
    sheet.add_row [ "Average Quality Rating" ]
    sheet.add_row [ "Overall Quality", avg_qual ]
  end

  def short_name
    name.delete_prefix("#{site.name} - ")
  end

  private
    def assign_name
      self.name = "#{site.name} - #{curriculum.title} (#{start_date.strftime('%m/%Y')} - #{end_date.strftime('%m/%Y')})"
    end

    def completed_only_if_all_sittings_completed
      if completed? && sittings.kept.any? { |sitting| !sitting.completed? }
        errors.add(:completed, "can't be true unless all sessions are completed")
      end
      if completed? && sittings.kept.empty?
        errors.add(:completed, "can't be true unless there is at least one session")
      end
      if completed? && section_participant_responses.size < participants.size
        errors.add(:completed, "can't be true unless all participants have a demographics response for this section")
      end
    end
end
