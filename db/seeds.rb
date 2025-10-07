# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

# # Find/Create roles
# admin = Role.find_or_create_by(name: "admin")
# facilitator = Role.find_or_create_by(name: "facilitator")
# observer = Role.find_or_create_by(name: "observer")
# viewer = Role.find_or_create_by(name: "viewer")

# if Rails.env.development?
#   # Find/Create default user used for testing
#   a = User.find_or_create_by(email_address: "user@example.com")
#   a.update!(name: "Test Admin", password: "Password1!")
#   UserRole.find_or_create_by(user_id: a.id, role_id: admin.id)
#   f = User.find_or_create_by(email_address: "user1@example.com")
#   f.update!(name: "Test Facilitator", password: "Password1!")
#   UserRole.find_or_create_by(user_id: f.id, role_id: facilitator.id)
#   o = User.find_or_create_by(email_address: "user2@example.com")
#   o.update!(name: "Test Observer", password: "Password1!")
#   UserRole.find_or_create_by(user_id: o.id, role_id: observer.id)
#   u = User.find_or_create_by(email_address: "user3@example.com")
#   u.update!(name: "Test User", password: "Password1!")
#   UserRole.find_or_create_by(user_id: u.id, role_id: viewer.id)

#   # Add test participants
#   100.times do |i|
#     Participant.create!(name: Faker::Name.name, category: [ "Youth", "Caregiver", "Youth Serving Professional" ].sample)
#   end
# end

# # Find/Create demographics questionnaire
# questionnaire = Questionnaire.find_by(title: "demographics")
# questionnaire ||= Questionnaire.create!(title: "demographics")
# # grade
# q1 = questionnaire.questions.find_or_create_by(identifier: "grade")
# q1.update(number: 1, question_type: :single_choice, required: true, text: "What is your current school grade?")
# q1.answers.find_or_create_by(text: "6th or less").update(number: 1, text: "6th or less")
# q1.answers.find_or_create_by(text: "7th").update(number: 2, text: "7th")
# q1.answers.find_or_create_by(text: "8th").update(number: 3, text: "8th")
# q1.answers.find_or_create_by(text: "9th").update(number: 4, text: "9th")
# q1.answers.find_or_create_by(text: "10th").update(number: 5, text: "10th")
# q1.answers.find_or_create_by(text: "11th").update(number: 6, text: "11th")
# q1.answers.find_or_create_by(text: "12th").update(number: 7, text: "12th")
# q1.answers.find_or_create_by(text: "GED").update(number: 8, text: "GED")
# q1.answers.find_or_create_by(text: "Technical/Vocational Training/College").update(number: 9, text: "Technical/Vocational Training/College")
# q1.answers.find_or_create_by(text: "Ungraded").update(number: 10, text: "Ungraded")
# q1.answers.find_or_create_by(text: "Not in School").update(number: 11, text: "Not in School")
# q1.answers.find_or_create_by(text: "Not Reported").update(number: 12, text: "Not Reported")
# # age
# q2 = questionnaire.questions.find_or_create_by(identifier: "age")
# q2.update(number: 2, question_type: :single_choice, required: true, text: "How old are you?")
# q2.answers.find_or_create_by(text: "10 yrs old or younger").update(number: 1, text: "10 yrs old or younger")
# q2.answers.find_or_create_by(text: "11 yrs").update(number: 2, text: "11 yrs")
# q2.answers.find_or_create_by(text: "12 yrs").update(number: 3, text: "12 yrs")
# q2.answers.find_or_create_by(text: "13 yrs").update(number: 4, text: "13 yrs")
# q2.answers.find_or_create_by(text: "14 yrs").update(number: 5, text: "14 yrs")
# q2.answers.find_or_create_by(text: "15 yrs").update(number: 6, text: "15 yrs")
# q2.answers.find_or_create_by(text: "16 yrs").update(number: 7, text: "16 yrs")
# q2.answers.find_or_create_by(text: "17 yrs").update(number: 8, text: "17 yrs")
# q2.answers.find_or_create_by(text: "18 yrs").update(number: 9, text: "18 yrs")
# q2.answers.find_or_create_by(text: "19 yrs").update(number: 10, text: "19 yrs")
# q2.answers.find_or_create_by(text: "20 yrs or older").update(number: 11, text: "20 yrs or older")
# q2.answers.find_or_create_by(text: "Unknown/Not reported").update(number: 12, text: "Unknown/Not reported")
# # sex
# q3 = questionnaire.questions.find_or_create_by(identifier: "sex")
# q3.update(number: 3, question_type: :single_choice, required: true, text: "What is your sex?")
# q3.answers.find_or_create_by(text: "Male").update(number: 1, text: "Male")
# q3.answers.find_or_create_by(text: "Female").update(number: 2, text: "Female")
# q3.answers.find_or_create_by(text: "Prefer not to say").update(number: 3, text: "Prefer not to say")
# q3.answers.find_or_create_by(text: "Not Reported").update(number: 4, text: "Not Reported")
# # race
# q4 = questionnaire.questions.find_or_create_by(identifier: "race")
# q4.update(number: 4, question_type: :multiple_choice, required: true, text: "Please select your racial identity(ies). Select all that apply.")
# q4.answers.find_or_create_by(text: "American Indian or Alaska Native").update(number: 1, text: "American Indian or Alaska Native")
# q4.answers.find_or_create_by(text: "Asian").update(number: 2, text: "Asian")
# q4.answers.find_or_create_by(text: "Black or African American").update(number: 3, text: "Black or African American")
# q4.answers.find_or_create_by(text: "Native Hawaiian or Other Pacific Islander").update(number: 4, text: "Native Hawaiian or Other Pacific Islander")
# q4.answers.find_or_create_by(text: "White").update(number: 5, text: "White")
# q4.answers.find_or_create_by(text: "More than one race").update(number: 6, text: "More than one race")
# q4.answers.find_or_create_by(text: "Not Reported").update(number: 7, text: "Not Reported")
# # ethnicity
# q5 = questionnaire.questions.find_or_create_by(identifier: "ethnicity")
# q5.update(number: 5, question_type: :single_choice, required: true, text: "Please select your ethnic identity.")
# q5.answers.find_or_create_by(text: "Hispanic or Latino/a").update(number: 1, text: "Hispanic or Latino/a")
# q5.answers.find_or_create_by(text: "Not Hispanic or Latino/a").update(number: 2, text: "Not Hispanic or Latino/a")
# q5.answers.find_or_create_by(text: "Not Reported").update(number: 3, text: "Not Reported")
# # gender
# q6 = questionnaire.questions.find_or_create_by(identifier: "gender")
# q6.update(number: 6, question_type: :single_choice, required: false, text: "What is your gender identity?")
# q6.answers.find_or_create_by(text: "Male").update(number: 1, text: "Male")
# q6.answers.find_or_create_by(text: "Female").update(number: 2, text: "Female")
# q6.answers.find_or_create_by(text: "Transgender Female To Male").update(number: 3, text: "Transgender Female To Male")
# q6.answers.find_or_create_by(text: "Transgender Male To Female").update(number: 4, text: "Transgender Male To Female")
# q6.answers.find_or_create_by(text: "Non-binary").update(number: 5, text: "Non-binary")
# q6.answers.find_or_create_by(text: "Something Else").update(number: 6, text: "Something Else")
# q6.answers.find_or_create_by(text: "Not Reported").update(number: 7, text: "Not Reported")
# # sexual orientation
# q7 = questionnaire.questions.find_or_create_by(identifier: "orientation")
# q7.update(number: 7, question_type: :single_choice, required: false, text: "What is your sexual orientation?")
# q7.answers.find_or_create_by(text: "Heterosexual").update(number: 1, text: "Heterosexual")
# q7.answers.find_or_create_by(text: "Bisexual").update(number: 2, text: "Bisexual")
# q7.answers.find_or_create_by(text: "Homosexual").update(number: 3, text: "Homosexual")
# q7.answers.find_or_create_by(text: "Something Else").update(number: 4, text: "Something Else")
# q7.answers.find_or_create_by(text: "Not Decided").update(number: 5, text: "Not Decided")
# q7.answers.find_or_create_by(text: "Not Reported").update(number: 6, text: "Not Reported")
# # allergies
# q8 = questionnaire.questions.find_or_create_by(identifier: "allergies")
# q8.update(number: 8, question_type: :long_answer, required: false, text: "Do you have any known allergies/illnesses?")
# # Find/Create fidelity monitoring questionnaire
# fidelity = Questionnaire.find_by(title: "fidelity monitoring")
# fidelity ||= Questionnaire.create!(title: "fidelity monitoring")
# # planned activities question
# q1 = fidelity.questions.find_or_create_by(identifier: "activities")
# q1.update(number: 1, question_type: :single_choice, required: true, text: "[ACTIVITY_NAME]")
# q1.answers.find_or_create_by(text: "Activity was delivered as intended using the associated materials and activities").update(number: 1, text: "Activity was delivered as intended using the associated materials and activities")
# q1.answers.find_or_create_by(text: "Activity was presented but delivery was modified").update(number: 2, text: "Activity was presented but delivery was modified")
# q1.answers.find_or_create_by(text: "Activity was delivered but content was modified").update(number: 3, text: "Activity was delivered but content was modified")
# q1.answers.find_or_create_by(text: "Activity was not presented").update(number: 4, text: "Activity was not presented")
# q2 = fidelity.questions.find_or_create_by(identifier: "engagement")
# q2.update(number: 2, question_type: :single_choice, required: true, text: "How much participant engagement occurred during this session?")
# q2.answers.find_or_create_by(text: "Low engagement: 10–30% of participants").update(number: 1, text: "Low engagement: 10–30% of participants")
# q2.answers.find_or_create_by(text: "Moderate engagement: 40–70% of participants").update(number: 2, text: "Moderate engagement: 40–70% of participants")
# q2.answers.find_or_create_by(text: "High engagement: 80–100% of participants").update(number: 3, text: "High engagement: 80–100% of participants")
# q3 = fidelity.questions.find_or_create_by(identifier: "delivery-modified-follow-up")
# q3.update(number: 3, question_type: :long_answer, required: false, text: "Provide a brief explanation describing why the delivery was changed and areas for improvement.")
# q4 = fidelity.questions.find_or_create_by(identifier: "content-modified-follow-up")
# q4.update(number: 4, question_type: :long_answer, required: false, text: "Provide a brief explanation describing why the activity was changed and areas for improvement.")
# q5 = fidelity.questions.find_or_create_by(identifier: "not-delivered-follow-up")
# q5.update(number: 5, question_type: :long_answer, required: false, text: "Provide a brief explanation describing why the activity was not presented and areas for improvement.")
# q6 = fidelity.questions.find_or_create_by(identifier: "additional-comments")
# q6.update(number: 6, question_type: :long_answer, required: false, text: "If there were any additional implementation challenges, provide a brief explanation below. If there were no challenges or all challenges were documented above, write N/A.")

# # Find/Create program observation form
# observation = Questionnaire.find_by(title: "program observation")
# observation ||= Questionnaire.create!(title: "program observation")
# q1 = observation.questions.find_or_create_by(identifier: "introduction")
# q1.update(number: 1, question_type: :text, required: false, text: "<p>The purpose of the observation form is to measure the fidelity and quality of
# implementation of the program delivery. The person who completes this form (i.e., the observer) should
# be someone who attends program sessions and is neither a facilitator nor a participant. Please use the
# guidelines below when completing the observation form and do not change the scoring provided; for
# example, do not select multiple answers or score a 1.5 rather than a 1 or a 2.</p> <p><b>You should complete the observation form <i>after viewing the entire session,</i> but you should read
# through the questions prior to the observation.</b> It is also helpful to take notes during your viewing;
# for example, for Question 1, each time a facilitator gives an explanation, place a checkmark next
# to the appropriate rating.</p>")
# q2 = observation.questions.find_or_create_by(identifier: "instructions")
# q2.update(number: 2, question_type: :text, required: false, text: "The following questions assess the overall quality of the program session and delivery
# of the information. Use your best judgment and do not select more than one response.")
# q3 = observation.questions.find_or_create_by(identifier: "clarity")
# q3.update(number: 3, question_type: :single_choice, required: true, text: "<b>In general, how clear were the program facilitator’s explanations of activities?</b>")
# q3.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Not clear")
# q3.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q3.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Moderately clear")
# q3.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q3.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Very clear")
# q3.update(answer_instructions: "1 - Most participants do not understand instructions and cannot proceed; many questions asked.<br>
# 3 - About half of the group understands, while the other half ask questions for clarification.<br>
# 5 - 90-100% of the participants begin and complete the activity/discussion with no hesitation and no questions.")
# q4 = observation.questions.find_or_create_by(identifier: "time-management")
# q4.update(number: 4, question_type: :single_choice, required: true, text: "<b>To what extent did the facilitator keep track of time during the session and activities?</b>")
# q4.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Not at all")
# q4.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q4.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Somewhat")
# q4.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q4.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "A lot")
# q4.update(answer_instructions: "1 - Facilitator does not have time to complete the material (particularly at the end of the session); regularly allows discussions to drag on (e.g., participants seem bored or begin discussing non-related issues in small groups).<br>3 - Misses a few points; sometimes allows discussions to drag on.<br>5 - Completes all content of the session; completes activities and discussions in a timely manner (using the suggested time limitations in the program manual, if available).")
# q5 = observation.questions.find_or_create_by(identifier: "speed")
# q5.update(number: 5, question_type: :single_choice, required: true, text: "<b>To what extent did the presentation of materials seem rushed or hurried?</b>")
# q5.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Very rushed")
# q5.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q5.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Somewhat rushed")
# q5.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q5.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Not at all rushed")
# q5.update(answer_instructions: "1 - Facilitator doesn’t allow time for discussion; doesn’t have time for examples;
# tells participants they are in a hurry; body language suggests stress or hurry.<br>3 - Some deletion of discussion/activities; sometimes states but does not explain material.<br>5 - Does not rush participants or speech but still completes all the materials; appears relaxed.")
# q6 = observation.questions.find_or_create_by(identifier: "comrehension")
# q6.update(number: 6, question_type: :single_choice, required: true, text: "<b>To what extent did the participants appear to understand the material?</b>")
# q6.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Little understanding")
# q6.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q6.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Some understanding")
# q6.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q6.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Good understanding")
# q6.update(answer_instructions: "Use your best judgment based on participant conversations and feedback.<br>
# Roughly: 1 - Less than 25% seem to understand; 3 - About half; 5 - 75-100% understand.")
# q7 = observation.questions.find_or_create_by(identifier: "participation")
# q7.update(number: 7, question_type: :single_choice, required: true, text: "<b>How actively did the group members participate in discussions and activities?</b>")
# q7.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Little participation")
# q7.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q7.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Some participation")
# q7.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q7.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Active participation")
# q7.update(answer_instructions: "Use your best judgment based on participant discussions and feedback.<br>
# Roughly, 1 - Less than 25% participate; 3 - About half participate. 5 - 75-100% participate.")
# q8 = observation.questions.find_or_create_by(identifier: "rating")
# q8.update(number: 8, question_type: :text, required: true, text: "<b>On the following scale, rate the facilitator on the following qualities:</b>")
# q9 = observation.questions.find_or_create_by(identifier: "knowledge")
# q9.update(number: 9, question_type: :single_choice, required: true, text: "<b>Knowledge of the program</b>")
# q9.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
# q9.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q9.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
# q9.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q9.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
# q9.update(answer_instructions: "1 - Cannot answer questions, mispronounces names; reads from the manual.<br>
# 5 - Provides information above and beyond what’s in the manual; seems very familiar with the concepts and answers questions with ease.")
# q10 = observation.questions.find_or_create_by(identifier: "enthusiasm")
# q10.update(number: 10, question_type: :single_choice, required: true, text: "<b>Level of enthusiasm</b>")
# q10.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
# q10.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q10.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
# q10.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q10.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
# q10.update(answer_instructions: "1 - Presents information in a dry and boring way; lacks personal connection to material;
# appears “burned out.”<br>5 - Makes clear that the program is a great opportunity; gets participants talking and
# excited; outgoing.")
# q11 = observation.questions.find_or_create_by(identifier: "confidence")
# q11.update(number: 11, question_type: :single_choice, required: true, text: "<b>Poise and confidence</b>")
# q11.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
# q11.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q11.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
# q11.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q11.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
# q11.update(answer_instructions: "1 - Appears nervous or hurried; does not have good eye contact.<br>5 - Does not hesitate in addressing concerns. Well organized, not nervous.")
# q12 = observation.questions.find_or_create_by(identifier: "communication")
# q12.update(number: 12, question_type: :single_choice, required: true, text: "<b>Rapport and communication with participants</b>")
# q12.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
# q12.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q12.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
# q12.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q12.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
# q12.update(answer_instructions: "1 – Doesn’t remember names; does not 'connect' with participants; acts distant or unfriendly.<br>5 - Gets participants talking and excited; very friendly; uses people’s names when appropriate;
# seems to understand the community and its needs.")
# q13 = observation.questions.find_or_create_by(identifier: "concerns")
# q13.update(number: 13, question_type: :single_choice, required: true, text: "<b>Ability to address questions/concerns</b>")
# q13.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
# q13.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q13.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
# q13.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q13.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
# q13.update(answer_instructions: "1 - Engages in 'power struggles'; responds negatively to comments; gives inaccurate
# information; doesn’t direct participants elsewhere for further info.<br>5 - Answers questions of fact with information, questions of value with validation; if doesn’t
# know the answer, is honest about it and directs them elsewhere.")
# q14 = observation.questions.find_or_create_by(identifier: "quality")
# q14.update(number: 14, question_type: :single_choice, required: true, text: "<b>Rate the overall quality of the program session.</b>")
# q14.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
# q14.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
# q14.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
# q14.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
# q14.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
# q14.update(answer_instructions: "Summary measure of all the preceding questions. Assesses both the extent of material covered
# and the performance of the facilitator.<br>
# Excellent sessions look like:<br><ul><li>Participants are doing rather than talking about activities</li><li>Non-judgmental responses to questions</li><li>Answering questions of fact with information, questions of value with validation</li><li>Good time management and well organized</li><li>Adequate pacing—not too fast and did not drag</li><li>Using effective checks for understanding</li></ul>
# Poor sessions look like:<ul><li>Lecture-style of presenting the content</li><li>Reading the content from the notebook</li><li>Stumbling along with the content and failing to make connections to what
# has been discussed previously or what participants are contributing</li><li>Uninvolved participants</li><li>Getting into power struggles with participants about the content</li><li>Judgmental responses</li><li>Flat affect and boring style</li><li>Unorganized and random</li><li>Loses track of time</li></ul>")
# q15 = observation.questions.find_or_create_by(identifier: "activities-planned")
# q15.update(number: 15, question_type: :number_answer, required: true, text: "<b>Number of activities planned for this session (as indicated in the lesson plans):</b>")
# q16 = observation.questions.find_or_create_by(identifier: "activities-completed")
# q16.update(number: 16, question_type: :number_answer, required: true, text: "<b>Number of activities completed during this session:</b>")
# q17 = observation.questions.find_or_create_by(identifier: "optional-questions")
# q17.update(number: 17, question_type: :text, required: false, text: "<b>Note:</b> The following questions (18, 19, and 20) are for grantee’s internal use only for program improvement
# purposes. These questions are optional and will not be reported to the Office of Population Affairs (OPA)
# for performance measurement purposes.")
# q18 = observation.questions.find_or_create_by(identifier: "implementation-problems")
# q18.update(number: 18, question_type: :long_answer, required: false, text: "<b>Briefly describe any implementation problems you noticed, including any major changes to the
# content or delivery of the material; time wasted in getting the session started or finished, etc:</b>")
# q19 = observation.questions.find_or_create_by(identifier: "major-strengths")
# q19.update(number: 19, question_type: :long_answer, required: false, text: "<b>Please note at least one major strength of the session and/or facilitator’s delivery of the material:</b>")
# q20 = observation.questions.find_or_create_by(identifier: "other-comments")
# q20.update(number: 20, question_type: :long_answer, required: false, text: "<b>Other Comments: Use the space below for additional comments regarding strengths or
# weaknesses of the session, particularly if there is anything that affected your ratings above.</b>")

# # Curiculla / Lessons / Activities
# # 1. FLASH High School
# flash = Curriculum.find_or_create_by!(title: "FLASH High School")
# lesson1 = flash.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.1	Warm up 1", "1.2	Introduce the FLASH unit", "1.3	Set Classroom expectations", "1.4	4 Corners",
#  "1.5	Anonymous questions", "1.6	Introduce FLASH homework expectations", "1.7	Exit Ticket 1" ].each do |name|
#   lesson1.activities.find_or_create_by!(name: name)
# end
# lesson2 = flash.lessons.find_or_create_by!(title: "Lesson 2")
# [ "2.1	Warm up 2", "2.2 Review the external reproductive organs", "2.3 Review the internal Reproductive organs",
#   "2.4 Define sexual response system terms", "2.5 Conclude and assign homework 2", "2.6 Exit ticket 2" ].each do |name|
#   lesson2.activities.find_or_create_by!(name: name)
# end
# lesson3 = flash.lessons.find_or_create_by!(title: "Lesson 3")
# [ "3.1 Warm up 3", "3.2 Process of conception", "3.3 Early signs of pregnancy and testing", "3.4 Trimesters",
# "3.5 Pregnancy review game", "3.5 Assign homework 3", "3.6 Exit ticket 3" ].each do |name|
#   lesson3.activities.find_or_create_by!(name: name)
# end
# lesson4 = flash.lessons.find_or_create_by!(title: "Lesson 4")
# [ "4.1 Warm up", "4.2 Definitions activity", "4.3 Video and Discussion", "4.4 Advice Column",
# "4.5 Assign Homework 4", "4.6 Exit ticket" ].each do |name|
#   lesson4.activities.find_or_create_by!(name: name)
# end
# lesson5 = flash.lessons.find_or_create_by!(title: "Lesson 5")
# [ "5.1 Warm up 5", "5.2 Administer sexual Attitudes survey", "5.3 Introduction to lesson",
# "5.4 Define Stereotype", "5.5 Facilitate Gender Box brainstorm", "5.6 Analyze Gender Pressure",
# "5.7 Facilitate scenario activity", "5.8 Assign homework 5", "5.9 Exit ticket 5" ].each do |name|
#   lesson5.activities.find_or_create_by!(name: name)
# end
# lesson6 = flash.lessons.find_or_create_by!(title: "Lesson 6")
# [ "6.1 Warm up 6", "6.2 Lead group activity", "6.3 Analyze Scenarios", "6.4 Communication skills demonstration",
# "6.5 Conclude lesson & Assign homework 6", "6.6 Exit ticket" ].each do |name|
#   lesson6.activities.find_or_create_by!(name: name)
# end
# lesson7 = flash.lessons.find_or_create_by!(title: "Lesson 7")
# [ "7.1 Warm up 7", "7.2 Share survey results", "7.3 Watch video and define terms", "7.4 Review Laws",
# "7.5 Discuss power and age differences", "7.6 Facilitate scenarios activity", "7.7 Summarize & Assign homework 7", "7.8 Exit ticket 7" ].each do |name|
#   lesson7.activities.find_or_create_by!(name: name)
# end
# lesson8 = flash.lessons.find_or_create_by!(title: "Lesson 8")
# [ "8.1 Warm up 8", "8.2 Lead technology brainstorm", "8.3 Evaluate brainstorm", "8.4 Discuss sexual violence",
# "8.5 Lead scenarios activity", "8.6 Assign homework", "8.7 Exit ticket 8" ].each do |name|
#   lesson8.activities.find_or_create_by!(name: name)
# end
# lesson9 = flash.lessons.find_or_create_by!(title: "Lesson 9")
# [ "9.1 Warm up 9", "9.2 Define abstinence", "9.3 Introduce refusal skills steps", "9.4 Lead refusal skill demo",
# "9.5 Practice", "9.6 Debrief and assign homework", "9.7 Exit ticket 9" ].each do |name|
#   lesson9.activities.find_or_create_by!(name: name)
# end
# lesson10 = flash.lessons.find_or_create_by!(title: "Lesson 10")
# [ "10.1 Warm up 10", "10.2 Lead birth control effectiveness exercise", "10.3 Study methods and create commercials",
# "10.4 Perform commercials", "10.5 Assign homework", "10.6 Exit ticket 10" ].each do |name|
#   lesson10.activities.find_or_create_by!(name: name)
# end
# lesson11 = flash.lessons.find_or_create_by!(title: "Lesson 11")
# [ "11.1 Warm up 11", "11.2 Lead graffiti Sheet activity", "11.3 Journaling activity",
# "11.4 Condom Demonstration", "11.5 Assign Homework", "11.6 Exit Ticket 11" ].each do |name|
#   lesson11.activities.find_or_create_by!(name: name)
# end
# lesson12 = flash.lessons.find_or_create_by!(title: "Lesson 12")
# [ "12.1 Warm up 12", "12.2 HIV/STD Overview", "12.3 Brainstorm condom barriers, solutions and benefits",
# "12.4 Discuss effectiveness of condoms", "12.5 Demonstration and practice of condoms",
# "12.6 Summarize and Assign Homework", "12.7 Exit ticket 12" ].each do |name|
#   lesson12.activities.find_or_create_by!(name: name)
# end
# lesson13 = flash.lessons.find_or_create_by!(title: "Lesson 13")
# [ "13.1 Warm up 13", "13.2 HIV Review quiz", "13.3 Research local testing resources", "13.4 Write Advice about STD testing",
# "13.5 Assign Homework", "13.6 Exit Ticket 13" ].each do |name|
#   lesson13.activities.find_or_create_by!(name: name)
# end
# lesson14 = flash.lessons.find_or_create_by!(title: "Lesson 14")
# [ "14.1 Warm up 14", "14.2 Explain bottom-line Decision making", "14.3 Endorse FLASH Bottom Lines",
# "14.4 Large group scenario activity", "14.5 Summarize and Assign Homework", "14.6 Exit ticket 14" ].each do |name|
#   lesson14.activities.find_or_create_by!(name: name)
# end
# lesson15 = flash.lessons.find_or_create_by!(title: "Lesson 15")
# [ "15.1 Warm up 15", "15.2 Explain social norms campaign", "15.3 Introduce social norms statements",
# "15.4 Students make posters", "15.5 Conclude", "15.6 Exit ticket 15" ].each do |name|
#   lesson15.activities.find_or_create_by!(name: name)
# end
# # 2. LOVE Notes 4.1
# love_notes = Curriculum.find_or_create_by!(title: "LOVE Notes 4.1")
# lnl1 = love_notes.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.1a Drawing and discussion", "1.1b relationships today", "1.2a Vision Building",
# "1.3a Red or Green Demonstration", "1.3b Parents relationships and children",
# "1.4a What is a trusted adult and how do I identify one?" ].each do |name|
#   lnl1.activities.find_or_create_by!(name: name)
# end
# lnl2 = love_notes.lessons.find_or_create_by!(title: "Lesson 2")
# [ "2.1 Good Relationships start with you", "2.2a Primary colors personality tool",
# "2.2b Strengthening Positive and Taming Extreme Tendencies",
# "2.3a Sorting baggage", "2.3b Examining Family Patterns",
# "2.3c Abuse and Childhood Hurts discussion", "2.4 Trusted adult connection 2" ].each do |name|
#   lnl2.activities.find_or_create_by!(name: name)
# end
# lnl3 = love_notes.lessons.find_or_create_by!(title: "Lesson 3")
# [ "3.1 What’s important?", "3.2a Reasonable or Unreasonable", "3.2b My expectations",
# "3.2c Practice Communicating Expectations", "3.2d Maturity and Character assessments",
# "3.3 Trusted adult Connection 3" ].each do |name|
#   lnl3.activities.find_or_create_by!(name: name)
# end
# lnl4 = love_notes.lessons.find_or_create_by!(title: "Lesson 4")
# [ "4.1a Group brainstorm", "4.1b Build a relationship", "4.1c Inverted Pyramid Presentation",
# "4.2a Glitter demonstration", "4.2b Video clip ASAPSCIENCE", "4.3 Trusted adult connection 4" ].each do |name|
#   lnl4.activities.find_or_create_by!(name: name)
# end
# lnl5 = love_notes.lessons.find_or_create_by!(title: "Lesson 5")
# [ "5.1a Thumbs Up or Down", "5.2a Identify that Principle", "5.3 Seven Questions to Ask",
# "5.4a Love Advisor", "5.4b Compatibility Checklist", "5.5 Trusted Adult Connection 5" ].each do |name|
#   lnl5.activities.find_or_create_by!(name: name)
# end
# lnl6 = love_notes.lessons.find_or_create_by!(title: "Lesson 6")
# [ "6.1a Relationship Sculptures", "6.1b Assessing Relationships", "6.2a Fun brainstorm Competition",
# "6.3a Is it Time?", "6.3b Better and Worse Ways", "6.3c Surviving a Breakup", "6.4 Trusted adult connection 6" ].each do |name|
#   lnl6.activities.find_or_create_by!(name: name)
# end
# lnl7 = love_notes.lessons.find_or_create_by!(title: "Lesson 7")
# [ "7.1a Red Flags", "7.1b Video Clip; Dating Violence", "7.1c Forms and Prevalence",
# "7.2a Types of physical partner violence", "7.2b Warning signs", "7.3a Tea and Consent video",
# "7.3b Discussion of consent", "7.4 Sex Trafficking- Prevention", "7.5a Draw the Line of Respect",
# "7.6 Trusted Adult Connection 7" ].each do |name|
#   lnl7.activities.find_or_create_by!(name: name)
# end
# lnl8 = love_notes.lessons.find_or_create_by!(title: "Lesson 8")
# [ "8.1a High Cost Slides", "8.2a Taking a low risk deciding approach",
# "8.2b Video DUI; Decisions under the influence", "8.3a Brief review",
# "8.3b Journal; Making Decisions", "8.4 Pathways and sequences Towards success",
# "8.5 Trusted adult connection 8" ].each do |name|
#   lnl8.activities.find_or_create_by!(name: name)
# end
# lnl9 = love_notes.lessons.find_or_create_by!(title: "Lesson 9")
# [ "9.1a Communication patterns", "9.2a Communication Danger signs", "9.3a The time out skills",
# "9.3b What's behind anger", "9.3c Anger and Stress video", "9.3d A Way to Help Calm Yourself",
# "9.4a Speaker Listener Practice", "9.4b Speaker Listener Log", "9.5 Trusted adult connection 9",
# "9.6 Face Time Video" ].each do |name|
#   lnl9.activities.find_or_create_by!(name: name)
# end
# lnl10 = love_notes.lessons.find_or_create_by!(title: "Lesson 10")
# [ "10.1a Practice; Identify the W,W and A", "10.1b Good or Bad Complaint",
# "10.1c Avoid Negative Starts; Be Gentle", "10.1d Journal & Video Clip",
# "10.2a My Hidden Issues Journal", "10.3a Problem- Solving in action",
# "10.4a Communication skill Match Game", "10.5a What Would My life Be Like",
# "10.5b Communication", "10.5c Emotional and Social Intelligence", "10.5d Mental Health",
# "10.6 Trusted Adult Connection 10" ].each do |name|
#   lnl10.activities.find_or_create_by!(name: name)
# end
# lnl11 = love_notes.lessons.find_or_create_by!(title: "Lesson 11")
# [ "11.1a Brainstorm, Poll and Discussion", "11.2a Dimensions of Intimacy", "11.2b Analyze a Relationship",
# "11.2c How Connected", "11.3a All Falls Down or Tooth paste video", "11.3b Discussion",
# "11.4a Potential Emotional Risk", "11.4b Benefits of Deciding", "11.5a Think Whats Next Video",
# "11.6a Body Basics Hormones and Sexual Arousal Patterns", "11.6b Safe Sex Reimagined",
# "11.6c Conversations for Getting on the Same Page", "11.7a Drawing My Line", "11.8 Trusted Adult Connection 11"
# ].each do |name|
#   lnl11.activities.find_or_create_by!(name: name)
# end
# lnl12 = love_notes.lessons.find_or_create_by!(title: "Lesson 12")
# [ "12.1a Test your Sex Smarts", "12.1b Birth Control Methods", "12.1c How Do You Get Pregnant Video",
# "12.1d How do Contraceptives Work", "12.2a Film, Reflection and Discussion", "12.2b Peer Teaching activity On STIs/HIV",
# "12.3a  My Personal Plan", "12.4 Trusted Adult Connection", "12.5a Interview with Billie Eilish & Discussion",
# "12.5b Video; The Science of Pornography", "12.6a Tips for assertiveness and Refusal", "12.6b Role-Play Practice" ].each do |name|
#   lnl12.activities.find_or_create_by!(name: name)
# end
# lnl13 = love_notes.lessons.find_or_create_by!(title: "Lesson 13")
# [ "13.1a Group Brainstorm", "13.1b A Childs wish list", "13.1c Discussion; What helps parents provide this",
# "13.2a Being a Good Father Means?", "13.2b Music video & Discussion", "13.2c Father Absence",
# "13.2d Health Relationships and Positive Fathering", "13.3a Child Speak: Bright Future",
# "13.4 Decisions About Living Together", "13.5a Review and Plan for success" ].each do |name|
#   lnl13.activities.find_or_create_by!(name: name)
# end
# # Positive Potential 6th Grade
# pp6 = Curriculum.find_or_create_by!(title: "Positive Potential 6th Grade")
# pp6l1 = pp6.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.1 Intro", "1.2	Stand up, sit down & Group agreements", "1.3	Five parts of the whole person",
# "1.4	True Value", "1.5	Legacy", "1.6	Positive and Negative influences", "1.7	Transition and Charge 1"
# ].each do |name|
#   pp6l1.activities.find_or_create_by!(name: name)
# end
# pp6l2 = pp6.lessons.find_or_create_by!(title: "Lesson 2")
# [ "2.1	Review", "2.2	Tug of war", "2.3	N.I.C.E", "2.4	Exit strategy!", "2.5	No Regrets Book (optional)",
# "2.6	Transition and Charge 2" ].each do |name|
#   pp6l2.activities.find_or_create_by!(name: name)
# end
# pp6l3 = pp6.lessons.find_or_create_by!(title: "Lesson 3")
# [ "3.1	Review", "3.2	Positive and Negative Future", "3.3	Priority Check", "3.4	Ashleys Story",
# "3.5	A.C.T Skills", "3.6	Transition and Charge 3" ].each do |name|
#   pp6l3.activities.find_or_create_by!(name: name)
# end
# pp6l4 = pp6.lessons.find_or_create_by!(title: "Lesson 4")
# [ "4.1	Review", "4.2	Influence and Outcomes", "4.3	Unhealthy Relationships",
# "4.4	Strong Foundations", "4.5	Transition and Charge 4" ].each do |name|
#   pp6l4.activities.find_or_create_by!(name: name)
# end
# pp6l5 = pp6.lessons.find_or_create_by!(title: "Lesson 5")
# [ "5.1 Review", "5.2 No Regrets Review (Optional)", "5.3 True That/ That’s Wack",
# "5.4 Its Not Too Late", "5.5 Measure Your Life", "5.6 For What Its Worth", "5.7 Transition and Charge 5" ].each do |name|
#   pp6l5.activities.find_or_create_by!(name: name)
# end
# # Positive Potential 7th Grade
# pp7 = Curriculum.find_or_create_by!(title: "Positive Potential 7th Grade")
# pp7l1 = pp7.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.8	Intro", "1.9	Would you rather & Group agreements", "1.10	Five parts of the whole person",
# "1.11	Building self confidence", "1.12	Now or Later", "1.13	Cyber Bullying",
# "1.14	The Whole Truth", "1.15	Transition and Charge 1" ].each do |name|
#   pp7l1.activities.find_or_create_by!(name: name)
# end
# pp7l2 = pp7.lessons.find_or_create_by!(title: "Lesson 2")
# [ "2.7	Review", "2.8	Jammal’s Story Part 1", "2.9	Entrapment", "2.10	Sexting",
# "2.11	Transition and Charge 2" ].each do |name|
#   pp7l2.activities.find_or_create_by!(name: name)
# end
# pp7l3 = pp7.lessons.find_or_create_by!(title: "Lesson 3")
# [ "3.7	Review", "3.8	Split Decisions", "3.9	Enlightenment", "3.10	Transition and Charge 3" ].each do |name|
#   pp7l3.activities.find_or_create_by!(name: name)
# end
# pp7l4 = pp7.lessons.find_or_create_by!(title: "Lesson 4")
# [ "4.6	Review", "4.7	Journey", "4.8	Stages/Timeline", "4.9	Transition and Charge 4" ].each do |name|
#   pp7l4.activities.find_or_create_by!(name: name)
# end
# pp7l5 = pp7.lessons.find_or_create_by!(title: "Lesson 5")
# [ "5.1 Review", "5.2 Jammal’s Story Part 2", "5.3 Building My Legacy", "5.4 Q&A",
# "5.5 Now or Later 2", "5.6 Final Transition and Charge 5" ].each do |name|
#   pp7l5.activities.find_or_create_by!(name: name)
# end
# # Positive Potential 8th Grade
# pp8 = Curriculum.find_or_create_by!(title: "Positive Potential 8th Grade")
# pp8l1 = pp8.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.1	Intro", "1.2	Would you rather & Group Agreements", "1.3	Five Part of the Whole Person",
# "1.4	What Goes Around Comes Around", "1.5	Road to Romance", "1.6	Transition and Charge 1" ].each do |name|
#   pp8l1.activities.find_or_create_by!(name: name)
# end
# pp8l2 = pp8.lessons.find_or_create_by!(title: "Lesson 2")
# [ "2.1 Review", "2.2A Stuck together (option 1)", "2.2B Choice Points (option 2)",
# "2.3 Streamline", "2.4 Transition and Charge 2" ].each do |name|
#   pp8l2.activities.find_or_create_by!(name: name)
# end
# pp8l3 = pp8.lessons.find_or_create_by!(title: "Lesson 3")
# [ "3.1 Review", "3.2 Multiple Choices", "3.3 Multiple Choices game", "3.4 Jay’s Story", "3.5 Transition and Charge 3" ].each do |name|
#   pp8l3.activities.find_or_create_by!(name: name)
# end
# pp8l4 = pp8.lessons.find_or_create_by!(title: "Lesson 4")
# [ "4.1 Review", "4.2 Are You in Control", "4.3 Refusal Skills", "4.4 Transition and Charge 4" ].each do |name|
#   pp8l4.activities.find_or_create_by!(name: name)
# end
# pp8l5 = pp8.lessons.find_or_create_by!(title: "Lesson 5")
# [ "5.1 Review", "5.2  Possible Future", "5.3 Transition and Charge 5" ].each do |name|
#   pp8l5.activities.find_or_create_by!(name: name)
# end
# # Hip Teens Activities
# hta = Curriculum.find_or_create_by!(title: "Hip Teens Activities")
# htal1 = hta.lessons.find_or_create_by!(title: "Lesson 1 Introduction and Rules of the group")
# [ "1. Intro of Group Members", "2. Group Orientation",
# "3.	Values Stack", "4.	Building Motivation: Group Member Concerns/Questions about HIV",
# "5.	HIV/AIDS; The Facts ", "6.	Card Swap",
# "7.	Define Assertive Communication & Introduce Role-plays to Practice Behavioral Skills",
# "8.	Wrap Up" ].each do |name|
#   htal1.activities.find_or_create_by!(name: name)
# end
# htal2 = hta.lessons.find_or_create_by!(title: "Lesson 2 Menu of Healthy Sexual Choices and Trigger Board")
# [ "1.	Review, Risk Continuum and Perception of HIV Risk",
# "2.	Risk Sensitization (Safer vs Less Safe Behaviors)",
# "3.	Develop Menu of Healthy Choices",
# "4.	Where are you on the HIP Teen Ruler",
# "5.	Pros and Cons of Condom Use",
# "6.	Review Assertive Statements using video clip",
# "7.	Wrap up" ].each do |name|
#   htal2.activities.find_or_create_by!(name: name)
# end
# htal3 = hta.lessons.find_or_create_by!(title: "Lesson 3 Trigger Board and How to use Condoms")
# [ "1.	Review", "2.	Trigger Board", "3.	Step-by Step instructions for condom use",
# "4.	Condom line up", "5.	What is a Good Goal", "6.	Video Clips- Using assertive statements",
# "7.	Wrap up" ].each do |name|
#   htal3.activities.find_or_create_by!(name: name)
# end
# htal4 = hta.lessons.find_or_create_by!(title: "Lesson 4")
# [ "1.	Review", "2. Assertive Statement training", "3.	Video Clips",
# "4.	Millionaire Game", "5.	HIPTeen Ruler Game", "6.	Wrap up" ].each do |name|
#   htal4.activities.find_or_create_by!(name: name)
# end
# # Hip Teens Activities 3-month reunion
# hta3 = Curriculum.find_or_create_by!(title: "Hip Teens 3-month Reunion")
# hta3l1 = hta3.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.	Intro, group guidelines, and getting reacquainted",
# "2.	Review of goals; Progress and challenges, triggers and assertiveness",
# "3.	Strengthening assertiveness and Skills for early intervention; Video clips and Role playing",
# "4.	Steps of condom use",
# "5.	Motivation Enhancement with the HIPTeens Ruler",
# "6.	Wrap up" ].each do |name|
#   hta3l1.activities.find_or_create_by!(name: name)
# end
# # Hip Teens Activities 6-month reunion
# hta4 = Curriculum.find_or_create_by!(title: "Hip Teens 6-month Reunion")
# hta4l1 = hta4.lessons.find_or_create_by!(title: "Lesson 1")
# [ "1.	Intro, Group guidelines, and getting reacquainted",
# "2.	Review of goals; Progress and challenges, triggers and assertiveness",
# "3.	Strengthening assertiveness and Skills for early intervention; Video clips and Role playing",
# "4.	Steps of condom use",
# "5.	Motivation Enhancement with the HIPTeens Ruler",
# "6.	Wrap up" ].each do |name|
#   hta4l1.activities.find_or_create_by!(name: name)
# end

# ENC-HEAL Community Engagement Tracking questionnaire
cet = Questionnaire.find_by(title: "Community Engagement Tracking")
cet ||= Questionnaire.create!(title: "Community Engagement Tracking")
# name
cet_q1 = cet.questions.find_or_create_by(identifier: "name")
cet_q1.update(number: 1, question_type: :long_answer, required: false, text: "Event Name:")
# date
cet_q2 = cet.questions.find_or_create_by(identifier: "date")
cet_q2.update(number: 2, question_type: :date_answer, required: false, text: "Event Date:")
# time
cet_q3 = cet.questions.find_or_create_by(identifier: "time")
cet_q3.update(number: 3, question_type: :time_answer, required: false, text: "Event Time:")
# organization
cet_q4 = cet.questions.find_or_create_by(identifier: "organization")
cet_q4.update(number: 4, question_type: :long_answer, required: false, text: "Host Organization Name:")
# event_type
cet_q5 = cet.questions.find_or_create_by(identifier: "event-type")
cet_q5.update(number: 5, question_type: :single_choice, required: false, text: "Type of Event:")
cet_q5.answers.find_or_create_by(text: "Tabled for ENC-HEAL").update(number: 1, text: "Tabled for ENC-HEAL")
cet_q5.answers.find_or_create_by(text: "Presented on ENC-HEAL to group").update(number: 2, text: "Presented on ENC-HEAL to group")
cet_q5.answers.find_or_create_by(text: "Parent Engagement").update(number: 3, text: "Parent Engagement")
cet_q5.answers.find_or_create_by(text: "Other").update(number: 4, text: "Other")
# settings
cet_q6 = cet.questions.find_or_create_by(identifier: "setting")
cet_q6.update(number: 6, question_type: :single_choice, required: false, text: "Setting(s):")
cet_q6.answers.find_or_create_by(text: "JCPC").update(number: 1, text: "JCPC")
cet_q6.answers.find_or_create_by(text: "School").update(number: 2, text: "School")
cet_q6.answers.find_or_create_by(text: "Community Setting").update(number: 3, text: "Community Setting")
cet_q6.answers.find_or_create_by(text: "Foster Care").update(number: 4, text: "Foster Care")
cet_q6.answers.find_or_create_by(text: "Other").update(number: 5, text: "Other")
# counties
cet_q7 = cet.questions.find_or_create_by(identifier: "counties")
cet_q7.update(number: 7, question_type: :single_choice, required: false, text: "County(ies) Represented Serves:")
cet_q7.answers.find_or_create_by(text: "Pitt").update(number: 1, text: "Pitt")
cet_q7.answers.find_or_create_by(text: "Martin").update(number: 2, text: "Martin")
cet_q7.answers.find_or_create_by(text: "Edgecombe").update(number: 3, text: "Edgecombe")
cet_q7.answers.find_or_create_by(text: "Nash").update(number: 4, text: "Nash")
cet_q7.answers.find_or_create_by(text: "Halifax").update(number: 5, text: "Halifax")
cet_q7.answers.find_or_create_by(text: "Craven").update(number: 6, text: "Craven")
cet_q7.answers.find_or_create_by(text: "Hertford").update(number: 7, text: "Hertford")
cet_q7.answers.find_or_create_by(text: "Other").update(number: 8, text: "Other")
# team members
cet_q8 = cet.questions.find_or_create_by(identifier: "team-members")
cet_q8.update(number: 8, question_type: :long_answer, required: false, text: "ENC-HEAL Team Members Present: ")
# partners
cet_q9 = cet.questions.find_or_create_by(identifier: "partners")
cet_q9.update(number: 9, question_type: :long_answer, required: false, text: "ENC-HEAL Partners Present: ")
# individuals
cet_q10 = cet.questions.find_or_create_by(identifier: "youth-individuals-attendance")
cet_q10.update(number: 10, question_type: :number_answer, required: false, text: "Number of Youth Individuals in Attendance: ")
cet_q11 = cet.questions.find_or_create_by(identifier: "youth-individuals-invited")
cet_q11.update(number: 11, question_type: :number_answer, required: false, text: "Number of Youth Individuals received project information: ")
cet_q12 = cet.questions.find_or_create_by(identifier: "caregivers-attendance")
cet_q12.update(number: 12, question_type: :number_answer, required: false, text: "Number of Caregivers (such as parents, guardians, foster parents of youth, etc) in Attendance: ")
cet_q13 = cet.questions.find_or_create_by(identifier: "caregivers-invited")
cet_q13.update(number: 13, question_type: :number_answer, required: false, text: "Number of Caregivers (such as parents, guardians, foster parents of youth, etc) received project information: ")
cet_q14 = cet.questions.find_or_create_by(identifier: "youth-serving-professionals-attendance")
cet_q14.update(number: 14, question_type: :number_answer, required: false, text: "Number of Youth-serving professionals (teachers, educators, social workers, clinical providers, other healthcare workers, juvenile justice officers, etc) in Attendance: ")
cet_q15 = cet.questions.find_or_create_by(identifier: "youth-serving-professionals-invited")
cet_q15.update(number: 15, question_type: :number_answer, required: false, text: "Number of Youth-serving professionals (teachers, educators, social workers, clinical providers, other healthcare workers, juvenile justice officers, etc) received project information: ")
cet_q16 = cet.questions.find_or_create_by(identifier: "community-members-attendance")
cet_q16.update(number: 16, question_type: :number_answer, required: false, text: "Number of Community members (such as faith leaders, business leaders, and any other members of the community) in Attendance: ")
cet_q17 = cet.questions.find_or_create_by(identifier: "community-members-invited")
cet_q17.update(number: 17, question_type: :number_answer, required: false, text: "Number of Community members (such as faith leaders, business leaders, and any other members of the community) received project information: ")
cet_q18 = cet.questions.find_or_create_by(identifier: "other-individuals-attendance")
cet_q18.update(number: 18, question_type: :number_answer, required: false, text: "Number of Other individuals in Attendance: ")
cet_q19 = cet.questions.find_or_create_by(identifier: "other-individuals-invited")
cet_q19.update(number: 19, question_type: :number_answer, required: false, text: "Number of Other individuals received project information: ")
# notes
cet_q20 = cet.questions.find_or_create_by(identifier: "notes")
cet_q20.update(number: 20, question_type: :text, required: false, text: "Notes from Event")
# other important information
cet_q21 = cet.questions.find_or_create_by(identifier: "other-important-information")
cet_q21.update(number: 21, question_type: :text, required: false, text: "Other Important Information")
