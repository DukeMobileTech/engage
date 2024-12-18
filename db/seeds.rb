# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Find/Create demographics questionnaire
questionnaire = Questionnaire.find_by(title: "demographics")
questionnaire ||= Questionnaire.create!(title: "demographics")
# grade
q1 = questionnaire.questions.find_or_create_by(identifier: "grade")
q1.update(number: 1, question_type: :single_choice, required: true, text: "What is your current school grade?")
q1.answers.find_or_create_by(text: "8th").update(number: 1, text: "8th")
q1.answers.find_or_create_by(text: "9th").update(number: 2, text: "9th")
q1.answers.find_or_create_by(text: "10th").update(number: 3, text: "10th")
q1.answers.find_or_create_by(text: "11th").update(number: 4, text: "11th")
q1.answers.find_or_create_by(text: "12th").update(number: 5, text: "12th")
# age
q2 = questionnaire.questions.find_or_create_by(identifier: "age")
q2.update(number: 2, question_type: :number_answer, required: true, text: "What is your age?")
# sex
q3 = questionnaire.questions.find_or_create_by(identifier: "sex")
q3.update(number: 3, question_type: :single_choice, required: true, text: "What sex were you assigned at birth?")
q3.answers.find_or_create_by(text: "Male").update(number: 1, text: "Male")
q3.answers.find_or_create_by(text: "Female").update(number: 2, text: "Female")
q3.answers.find_or_create_by(text: "Decline to state").update(number: 3, text: "Decline to state")
# race
q4 = questionnaire.questions.find_or_create_by(identifier: "race")
q4.update(number: 4, question_type: :multiple_choice, required: true, text: "Please indicate one or more races that apply to you.")
q4.answers.find_or_create_by(text: "American Indian or Alaska Native").update(number: 1, text: "American Indian or Alaska Native")
q4.answers.find_or_create_by(text: "Asian").update(number: 2, text: "Asian")
q4.answers.find_or_create_by(text: "Black or African American").update(number: 3, text: "Black or African American")
q4.answers.find_or_create_by(text: "Native Hawaiian or Other Pacific Islander").update(number: 4, text: "Native Hawaiian or Other Pacific Islander")
q4.answers.find_or_create_by(text: "White").update(number: 5, text: "White")
q4.answers.find_or_create_by(text: "Decline to state").update(number: 6, text: "Decline to state")
# ethnicity
q5 = questionnaire.questions.find_or_create_by(identifier: "ethnicity")
q5.update(number: 5, question_type: :single_choice, required: true, text: "Please designate your ethnicity.")
q5.answers.find_or_create_by(text: "Hispanic or Latino").update(number: 1, text: "Hispanic or Latino")
q5.answers.find_or_create_by(text: "Not Hispanic or Latino").update(number: 2, text: "Not Hispanic or Latino")
q5.answers.find_or_create_by(text: "Decline to state").update(number: 3, text: "Decline to state")
# gender
q6 = questionnaire.questions.find_or_create_by(identifier: "gender")
q6.update(number: 6, question_type: :single_choice, required: false, text: "Which best describes your current gender identity?")
q6.answers.find_or_create_by(text: "Cisgender Man").update(number: 1, text: "Cisgender Man")
q6.answers.find_or_create_by(text: "Cisgender Woman").update(number: 2, text: "Cisgender Woman")
q6.answers.find_or_create_by(text: "Transgender Man").update(number: 3, text: "Transgender Man")
q6.answers.find_or_create_by(text: "Transgender Woman").update(number: 4, text: "Transgender Woman")
q6.answers.find_or_create_by(text: "Non-binary Person").update(number: 5, text: "Non-binary Person")
q6.answers.find_or_create_by(text: "Other").update(number: 6, text: "Other")
q6.answers.find_or_create_by(text: "Decline to state").update(number: 7, text: "Decline to state")
