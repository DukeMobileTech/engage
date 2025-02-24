# == Schema Information
#
# Table name: data_uploads
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DataUpload < ApplicationRecord
  has_many_attached :reports
  has_many :section_data_uploads, dependent: :destroy
  has_many :sections, through: :section_data_uploads

  validates :name, presence: true

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
    YouthParticipantCt	SexMaleCt	SexFemaleCt	SexNotReportedCt	GenderIdMale
    GenderIdFemale	GenderIdFTM	GenderIdMTF	GenderIdNeither	GenderIdSomethingElse
    GenderIdNotReported	OrientationHetero	OrientationBi	OrientationHomo
    OrientationSomethingElse	OrientationNotDecided	OrientationNotReported
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
      row = [ "", "", section.curriculum.title, section.name, section.site.state, section.site.urbanicity, section.site.setting ]
      # Youth Participant Counts
      youth = section.section_participants.where(participant_id: section.participants.where(category: "Youth").pluck(:id))
      sexes = youth.map { |p| p.sex }
      ys_row = [ youth.count, sexes.count("Male"), sexes.count("Female"), sexes.count("Not Reported") + sexes.count(nil) ]
      row += ys_row
      gender = youth.map { |p| p.gender }
      yg_row = [ gender.count("Cisgender Man"), gender.count("Cisgender Woman"),
                 gender.count("Transgender Man"), gender.count("Transgender Woman"),
                 gender.count("Non-binary Person"), gender.count("Other"),
                 gender.count("Not Reported") + gender.count(nil) ]
      row += yg_row
      orient = youth.map { |p| p.orientation }
      yo_row = [ orient.count("Straight or heterosexual"), orient.count("Bisexual"),
                 orient.count("Lesbian, gay, or homosexual"), orient.count("Something Else"),
                 orient.count("Have not Decided"), orient.count("Not Reported") + orient.count(nil) ]
      row += yo_row
      native, native_hispanic, native_non_hispanic = section.race_ethnicity_counts(youth, "American Indian or Alaska Native")
      asian, asian_hispanic, asian_non_hispanic = section.race_ethnicity_counts(youth, "Asian")
      black, black_hispanic, black_non_hispanic = section.race_ethnicity_counts(youth, "Black or African American")
      islander, islander_hispanic, islander_non_hispanic = section.race_ethnicity_counts(youth, "Native Hawaiian or Other Pacific Islander")
      white, white_hispanic, white_non_hispanic = section.race_ethnicity_counts(youth, "White")
      multiple = youth.select { |p| p.race&.include?(",") }
      m_hispanic = multiple.select { |m| m.ethnicity == "Hispanic or Latino" }
      m_non_hispanic = multiple.select { |m| m.ethnicity == "Not Hispanic or Latino" }
      unreported = youth.select { |p| (p.race == "Not Reported" || p.race.blank?) }
      u_hispanic = unreported.select { |u| u.ethnicity == "Hispanic or Latino" }
      u_non_hispanic = unreported.select { |u| u.ethnicity == "Not Hispanic or Latino" }
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
                 age.count("17 yrs"), age.count("18 yrs"), age.count("19 yrs or older"), "",
                 age.count("Not Reported") + age.count(nil) ]
      row += ya_row
      grade = youth.map { |p| p.grade }
      yg_row = [ grade.count("6th or less"), grade.count("7th"), grade.count("8th"),
                 grade.count("9th"), grade.count("10th"), grade.count("11th"),
                 grade.count("12th"), grade.count("GED"), grade.count("Technical/Vocational Training/College"),
                 grade.count("Ungraded"), grade.count("Not in School"), grade.count("Not Reported") + grade.count(nil) ]
      row += yg_row
      # Caregiver Counts
      rows << row
    end
    rows
  end
end
