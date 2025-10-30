# == Schema Information
#
# Table name: data_uploads
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  reporting_period_end   :date
#  reporting_period_start :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class DataUpload < ApplicationRecord
  has_many_attached :reports

  validates :name, :reporting_period_end, :reporting_period_start, presence: true

  def generate_report
    tempfile = Tempfile.new(Time.now.to_i.to_s)
    # create csv file
    CSV.open(tempfile, "w") do |csv|
      csv << report_header
      report_data.each do |row|
        csv << row
      end
    end
    reports.attach(io: File.open(tempfile.path),
                   filename: "#{name} Data Upload (#{DateTime.now.strftime("%F %H:%M %p")}).csv",
                   content_type: "text/csv")
  end

  def report_header
    %w[GrantNumber IOName	ProgramModel SectionName State	Urbanicity	Setting
    YouthParticipantCt	SexMaleCt	SexFemaleCt	SexNotReportedCt
    RaceNatAmerHispanicCt	RaceNatAmerNonHispanicCt	RaceNatAmerNotReportedCt
    RaceAsianHispanicCt	RaceAsianNonHispanicCt	RaceAsianNotReportedCt
    RaceBlackHispanicCt	RaceBlackNonHispanicCt	RaceBlackNotReportedCt
    RacePacIslHispanicCt	RacePacIslNonHispanicCt	RacePacIslNotReportedCt
    RaceWhiteHispanicCt	RaceWhiteNonHispanicCt	RaceWhiteNotReportedCt
    RaceMultipleHispanicCt	RaceMultipleNonHispanicCt	RaceMultipleNotReportedCt
    RaceNotReportedHispanicCt	RaceNotReportedNonHispanicCt	RaceNotReportedNotReportedCt
    Age10orYoungerCt	Age11Ct	Age12Ct	Age13Ct	Age14Ct	Age15Ct	Age16Ct	Age17Ct	Age18Ct
    Age19Ct	Age20orOlderCt	AgeNotReportedCt	Grade6orLessCt	Grade7Ct	Grade8Ct	Grade9Ct
    Grade10Ct	Grade11Ct	Grade12Ct	GradeGedCt	GradeCollegeCt	GradeUngradedCt	GradeNotInSchoolCt
    GradeNotReportedCt	CaregiverCt	CaregiverRaceNatAmerHispanicCt	CaregiverRaceNatAmerNonHispanicCt
    CaregiverRaceNatAmerNotReportedCt	CaregiverRaceAsianHispanicCt	CaregiverRaceAsianNonHispanicCt
    CaregiverRaceAsianNotReportedCt	CaregiverRaceBlackHispanicCt	CaregiverRaceBlackNonHispanicCt
    CaregiverRaceBlackNotReportedCt	CaregiverRacePacIslHispanicCt	CaregiverRacePacIslNonHispanicCt
    CaregiverRacePacIslNotReportedCt	CaregiverRaceWhiteHispanicCt	CaregiverRaceWhiteNonHispanicCt
    CaregiverRaceWhiteNotReportedCt	CaregiverRaceMultipleHispanicCt	CaregiverRaceMultipleNonHispanicCt
    CaregiverRaceMultipleNotReportedCt	CaregiverRaceNotReportedHispanicCt	CaregiverRaceNotReportedNonHispanicCt
    CaregiverRaceNotReportedNotReportedCt	YouthServingProfessionalCt	ProfessionalRaceNatAmerHispanicCt
    ProfessionalRaceNatAmerNonHispanicCt	ProfessionalRaceNatAmerNotReportedCt	ProfessionalRaceAsianHispanicCt
    ProfessionalRaceAsianNonHispanicCt	ProfessionalRaceAsianNotReportedCt	ProfessionalRaceBlackHispanicCt
    ProfessionalRaceBlackNonHispanicCt	ProfessionalRaceBlackNotReportedCt	ProfessionalRacePacIslHispanicCt
    ProfessionalRacePacIslNonHispanicCt	ProfessionalRacePacIslNotReportedCt	ProfessionalRaceWhiteHispanicCt
    ProfessionalRaceWhiteNonHispanicCt	ProfessionalRaceWhiteNotReportedCt	ProfessionalRaceMultipleHispanicCt
    ProfessionalRaceMultipleNonHispanicCt	ProfessionalRaceMultipleNotReportedCt	ProfessionalRaceNotReportedHispanicCt
    ProfessionalRaceNotReportedNonHispanicCt	ProfessionalRaceNotReportedNotReportedCt	ParticipantAttendPct
    Participant75Ct	SessionsPlannedCt	SessionsCompletedCt	SessionsObservedCt	AdherencePct	QualityOverallPt]
  end

  def report_data
    rows = []
    sections.each do |section|
      row = [ GRANT_NUMBER, section.site.organization.name, section.curriculum.program_model, section.name, section.site.state, section.site.urbanicity, section.site.setting ]
      # Youth Counts
      youth = section.section_participants.where(participant_id: section.participants.where(category: "Youth").pluck(:id))
      sexes = youth.map { |p| p.sex }
      ys_row = [ youth.count, sexes.count("Male"), sexes.count("Female"), sexes.count("Not Reported") + sexes.count(nil) + sexes.count("Prefer not to say") ]
      row += ys_row
      native, native_hispanic, native_non_hispanic = section.race_ethnicity_counts(youth, "American Indian or Alaska Native")
      asian, asian_hispanic, asian_non_hispanic = section.race_ethnicity_counts(youth, "Asian")
      black, black_hispanic, black_non_hispanic = section.race_ethnicity_counts(youth, "Black or African American")
      islander, islander_hispanic, islander_non_hispanic = section.race_ethnicity_counts(youth, "Native Hawaiian or Other Pacific Islander")
      white, white_hispanic, white_non_hispanic = section.race_ethnicity_counts(youth, "White")
      multiple = youth.select { |p| p.race&.include?(",") || p.race == "More than one race" }
      m_hispanic = multiple.select { |m| m.ethnicity == "Hispanic or Latino/a" }
      m_non_hispanic = multiple.select { |m| m.ethnicity == "Not Hispanic or Latino/a" }
      unreported = youth.select { |p| (p.race == "Not Reported" || p.race.blank?) }
      u_hispanic = unreported.select { |u| u.ethnicity == "Hispanic or Latino/a" }
      u_non_hispanic = unreported.select { |u| u.ethnicity == "Not Hispanic or Latino/a" }
      yr_row = [ native_hispanic, native_non_hispanic, (native - native_hispanic - native_non_hispanic),
                 asian_hispanic, asian_non_hispanic, (asian - asian_hispanic - asian_non_hispanic),
                 black_hispanic, black_non_hispanic, (black - black_hispanic - black_non_hispanic),
                 islander_hispanic, islander_non_hispanic, (islander - islander_hispanic - islander_non_hispanic),
                 white_hispanic, white_non_hispanic, (white - white_hispanic - white_non_hispanic),
                 m_hispanic.count, m_non_hispanic.count, (multiple.count - m_hispanic.count - m_non_hispanic.count),
                 u_hispanic.count, u_non_hispanic.count, (unreported.count - u_hispanic.count - u_non_hispanic.count)
                ]
      row += yr_row
      age = youth.map { |p| p.age }
      ya_row = [ age.count("10 yrs old or younger"), age.count("11 yrs"), age.count("12 yrs"),
                 age.count("13 yrs"), age.count("14 yrs"), age.count("15 yrs"), age.count("16 yrs"),
                 age.count("17 yrs"), age.count("18 yrs"), age.count("19 yrs"), age.count("20 yrs or older"),
                 age.count("Not Reported") + age.count(nil) ]
      row += ya_row
      grade = youth.map { |p| p.grade }
      yg_row = [ grade.count("6th or less"), grade.count("7th"), grade.count("8th"),
                 grade.count("9th"), grade.count("10th"), grade.count("11th"),
                 grade.count("12th"), grade.count("GED"), grade.count("Technical/Vocational Training/College"),
                 grade.count("Ungraded"), grade.count("Not in School"), grade.count("Not Reported") + grade.count(nil) ]
      row += yg_row
      # Caregiver Counts
      cg = section.section_participants.where(participant_id: section.participants.where(category: "Caregiver").pluck(:id))
      row << cg.size
      cg_nat, cg_nat_his, cg_nat_non_his = section.race_ethnicity_counts(cg, "American Indian or Alaska Native")
      cg_asi, cg_asi_his, cg_asi_non_his = section.race_ethnicity_counts(cg, "Asian")
      cg_bla, cg_bla_his, cg_bla_non_his = section.race_ethnicity_counts(cg, "Black or African American")
      cg_isl, cg_isl_his, cg_isl_non_his = section.race_ethnicity_counts(cg, "Native Hawaiian or Other Pacific Islander")
      cg_whi, cg_whi_his, cg_whi_non_his = section.race_ethnicity_counts(cg, "White")
      cg_mul = cg.select { |p| p.race&.include?(",") || p.race == "More than one race" }
      cgm_his = cg_mul.select { |m| m.ethnicity == "Hispanic or Latino/a" }
      cgm_non_his = cg_mul.select { |m| m.ethnicity == "Not Hispanic or Latino/a" }
      cg_un_rep = cg.select { |p| (p.race == "Not Reported" || p.race.blank?) }
      cg_un_rep_his = cg_un_rep.select { |u| u.ethnicity == "Hispanic or Latino/a" }
      cg_un_rep_non_his = cg_un_rep.select { |u| u.ethnicity == "Not Hispanic or Latino/a" }
      cgr_row = [ cg_nat_his, cg_nat_non_his, (cg_nat - cg_nat_his - cg_nat_non_his),
                  cg_asi_his, cg_asi_non_his, (cg_asi - cg_asi_his - cg_asi_non_his),
                  cg_bla_his, cg_bla_non_his, (cg_bla - cg_bla_his - cg_bla_non_his),
                  cg_isl_his, cg_isl_non_his, (cg_isl - cg_isl_his - cg_isl_non_his),
                  cg_whi_his, cg_whi_non_his, (cg_whi - cg_whi_his - cg_whi_non_his),
                  cgm_his.count, cgm_non_his.count, (cg_mul.count - cgm_his.count - cgm_non_his.count),
                  cg_un_rep_his.count, cg_un_rep_non_his.count, (cg_un_rep.count - cg_un_rep_his.count - cg_un_rep_non_his.count)
                ]
      row += cgr_row
      # Youth Serving Professional Counts
      ysp = section.section_participants.where(participant_id: section.participants.where(category: "Youth Serving Professional").pluck(:id))
      row << ysp.size
      ysp_nat, ysp_nat_his, ysp_nat_non_his = section.race_ethnicity_counts(ysp, "American Indian or Alaska Native")
      ysp_asi, ysp_asi_his, ysp_asi_non_his = section.race_ethnicity_counts(ysp, "Asian")
      ysp_bla, ysp_bla_his, ysp_bla_non_his = section.race_ethnicity_counts(ysp, "Black or African American")
      ysp_isl, ysp_isl_his, ysp_isl_non_his = section.race_ethnicity_counts(ysp, "Native Hawaiian or Other Pacific Islander")
      ysp_whi, ysp_whi_his, ysp_whi_non_his = section.race_ethnicity_counts(ysp, "White")
      ysp_mul = ysp.select { |p| p.race&.include?(",") || p.race == "More than one race" }
      yspm_his = ysp_mul.select { |m| m.ethnicity == "Hispanic or Latino/a" }
      yspm_non_his = ysp_mul.select { |m| m.ethnicity == "Not Hispanic or Latino/a" }
      ysp_un_rep = ysp.select { |p| (p.race == "Not Reported" || p.race.blank?) }
      ysp_un_rep_his = ysp_un_rep.select { |u| u.ethnicity == "Hispanic or Latino/a" }
      ysp_un_rep_non_his = ysp_un_rep.select { |u| u.ethnicity == "Not Hispanic or Latino/a" }
      yspr_row = [ ysp_nat_his, ysp_nat_non_his, (ysp_nat - ysp_nat_his - ysp_nat_non_his),
                   ysp_asi_his, ysp_asi_non_his, (ysp_asi - ysp_asi_his - ysp_asi_non_his),
                   ysp_bla_his, ysp_bla_non_his, (ysp_bla - ysp_bla_his - ysp_bla_non_his),
                   ysp_isl_his, ysp_isl_non_his, (ysp_isl - ysp_isl_his - ysp_isl_non_his),
                   ysp_whi_his, ysp_whi_non_his, (ysp_whi - ysp_whi_his - ysp_whi_non_his),
                   yspm_his.count, yspm_non_his.count, (ysp_mul.count - yspm_his.count - yspm_non_his.count),
                   ysp_un_rep_his.count, ysp_un_rep_non_his.count, (ysp_un_rep.count - ysp_un_rep_his.count - ysp_un_rep_non_his.count)
                ]
      row += yspr_row
      # rest
      sessions_planned = section.sittings.kept.size
      sessions_completed = section.completed_sittings.size
      sessions_observed = section.observations&.size || 0
      avg_adh, avg_qual = section.average_adherence_and_quality
      row += [ section.average_attendance, section.participants_meeting_target_attendance.size,
        sessions_planned, sessions_completed, sessions_observed, avg_adh, avg_qual ]
      # full row
      rows << row
    end
    rows
  end

  # sections to include are those that have been completed and whose end_dates
  # are within the date range reporting_period_start and reporting_period_end
  def sections
    Section.kept.completed.where(end_date: reporting_period_start..reporting_period_end)
                          .where(reported: true)
                          .includes(:site, :curriculum, :section_participants, :participants, :sittings)
  end
end
