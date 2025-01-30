# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Find/Create roles
admin = Role.find_or_create_by(name: "admin")
facilitator = Role.find_or_create_by(name: "facilitator")
observer = Role.find_or_create_by(name: "observer")
user = Role.find_or_create_by(name: "user")

# Find/Create default user used for testing
a = User.find_or_create_by(email_address: "user@example.com")
a.update!(name: "Test Admin", password: "Password1!")
UserRole.find_or_create_by(user_id: a.id, role_id: admin.id)
f = User.find_or_create_by(email_address: "user1@example.com")
f.update!(name: "Test Facilitator", password: "Password1!")
UserRole.find_or_create_by(user_id: f.id, role_id: facilitator.id)
o = User.find_or_create_by(email_address: "user2@example.com")
o.update!(name: "Test Observer", password: "Password1!")
UserRole.find_or_create_by(user_id: o.id, role_id: observer.id)
u = User.find_or_create_by(email_address: "user3@example.com")
u.update!(name: "Test User", password: "Password1!")
UserRole.find_or_create_by(user_id: u.id, role_id: user.id)

# Find/Create demographics questionnaire
questionnaire = Questionnaire.find_by(title: "demographics")
questionnaire ||= Questionnaire.create!(title: "demographics")
# grade
q1 = questionnaire.questions.find_or_create_by(identifier: "grade")
q1.update(number: 1, question_type: :single_choice, required: true, text: "What is your current school grade?")
q1.answers.find_or_create_by(text: "6th or less").update(number: 1, text: "6th or less")
q1.answers.find_or_create_by(text: "7th").update(number: 2, text: "7th")
q1.answers.find_or_create_by(text: "8th").update(number: 3, text: "8th")
q1.answers.find_or_create_by(text: "9th").update(number: 4, text: "9th")
q1.answers.find_or_create_by(text: "10th").update(number: 5, text: "10th")
q1.answers.find_or_create_by(text: "11th").update(number: 6, text: "11th")
q1.answers.find_or_create_by(text: "12th").update(number: 7, text: "12th")
q1.answers.find_or_create_by(text: "GED").update(number: 8, text: "GED")
q1.answers.find_or_create_by(text: "Technical/Vocational Training/College").update(number: 9, text: "Technical/Vocational Training/College")
q1.answers.find_or_create_by(text: "Ungraded").update(number: 10, text: "Ungraded")
q1.answers.find_or_create_by(text: "Not in School").update(number: 11, text: "Not in School")
q1.answers.find_or_create_by(text: "Not Reported").update(number: 12, text: "Not Reported")
# age
q2 = questionnaire.questions.find_or_create_by(identifier: "age")
q2.update(number: 2, question_type: :single_choice, required: true, text: "How old are you?")
q2.answers.find_or_create_by(text: "10 yrs old or younger").update(number: 1, text: "10 yrs old or younger")
q2.answers.find_or_create_by(text: "11 yrs").update(number: 2, text: "11 yrs")
q2.answers.find_or_create_by(text: "12 yrs").update(number: 3, text: "12 yrs")
q2.answers.find_or_create_by(text: "13 yrs").update(number: 4, text: "13 yrs")
q2.answers.find_or_create_by(text: "14 yrs").update(number: 5, text: "14 yrs")
q2.answers.find_or_create_by(text: "15 yrs").update(number: 6, text: "15 yrs")
q2.answers.find_or_create_by(text: "16 yrs").update(number: 7, text: "16 yrs")
q2.answers.find_or_create_by(text: "17 yrs").update(number: 8, text: "17 yrs")
q2.answers.find_or_create_by(text: "18 yrs").update(number: 9, text: "18 yrs")
q2.answers.find_or_create_by(text: "19 yrs or older").update(number: 10, text: "19 yrs or older")
q2.answers.find_or_create_by(text: "Unknown/Not reported").update(number: 11, text: "Unknown/Not reported")
# sex
q3 = questionnaire.questions.find_or_create_by(identifier: "sex")
q3.update(number: 3, question_type: :single_choice, required: true, text: "What sex were you assigned at birth?")
q3.answers.find_or_create_by(text: "Male").update(number: 1, text: "Male")
q3.answers.find_or_create_by(text: "Female").update(number: 2, text: "Female")
q3.answers.find_or_create_by(text: "Not Reported").update(number: 3, text: "Not Reported")
# race
q4 = questionnaire.questions.find_or_create_by(identifier: "race")
q4.update(number: 4, question_type: :multiple_choice, required: true, text: "Please indicate one or more races that apply to you.")
q4.answers.find_or_create_by(text: "American Indian or Alaska Native").update(number: 1, text: "American Indian or Alaska Native")
q4.answers.find_or_create_by(text: "Asian").update(number: 2, text: "Asian")
q4.answers.find_or_create_by(text: "Black or African American").update(number: 3, text: "Black or African American")
q4.answers.find_or_create_by(text: "Native Hawaiian or Other Pacific Islander").update(number: 4, text: "Native Hawaiian or Other Pacific Islander")
q4.answers.find_or_create_by(text: "White").update(number: 5, text: "White")
q4.answers.find_or_create_by(text: "Not Reported").update(number: 6, text: "Not Reported")
# ethnicity
q5 = questionnaire.questions.find_or_create_by(identifier: "ethnicity")
q5.update(number: 5, question_type: :single_choice, required: true, text: "Please designate your ethnicity.")
q5.answers.find_or_create_by(text: "Hispanic or Latino").update(number: 1, text: "Hispanic or Latino")
q5.answers.find_or_create_by(text: "Not Hispanic or Latino").update(number: 2, text: "Not Hispanic or Latino")
q5.answers.find_or_create_by(text: "Not Reported").update(number: 3, text: "Not Reported")
# gender
q6 = questionnaire.questions.find_or_create_by(identifier: "gender")
q6.update(number: 6, question_type: :single_choice, required: false, text: "Which best describes your current gender identity?")
q6.answers.find_or_create_by(text: "Cisgender Man").update(number: 1, text: "Cisgender Man")
q6.answers.find_or_create_by(text: "Cisgender Woman").update(number: 2, text: "Cisgender Woman")
q6.answers.find_or_create_by(text: "Transgender Man").update(number: 3, text: "Transgender Man")
q6.answers.find_or_create_by(text: "Transgender Woman").update(number: 4, text: "Transgender Woman")
q6.answers.find_or_create_by(text: "Non-binary Person").update(number: 5, text: "Non-binary Person")
q6.answers.find_or_create_by(text: "Other").update(number: 6, text: "Other")
q6.answers.find_or_create_by(text: "Not Reported").update(number: 7, text: "Not Reported")
# sexual orientation
q7 = questionnaire.questions.find_or_create_by(identifier: "orientation")
q7.update(number: 7, question_type: :single_choice, required: false, text: "Which best describes your sexual orientation?")
q7.answers.find_or_create_by(text: "Straight or heterosexual").update(number: 1, text: "Straight or heterosexual")
q7.answers.find_or_create_by(text: "Bisexual").update(number: 2, text: "Bisexual")
q7.answers.find_or_create_by(text: "Lesbian, gay, or homosexual").update(number: 3, text: "Lesbian, gay, or homosexual")
q7.answers.find_or_create_by(text: "Something Else").update(number: 4, text: "Something Else")
q7.answers.find_or_create_by(text: "Have not Decided").update(number: 5, text: "Have not Decided")
q7.answers.find_or_create_by(text: "Not Reported").update(number: 6, text: "Not Reported")

# Find/Create fidelity monitoring questionnaire
fidelity = Questionnaire.find_by(title: "fidelity monitoring")
fidelity ||= Questionnaire.create!(title: "fidelity monitoring")
# planned activities question
q1 = fidelity.questions.find_or_create_by(identifier: "activities")
q1.update(number: 1, question_type: :single_choice, required: true, text: "[ACTIVITY_NAME]")
q1.answers.find_or_create_by(text: "as-intended").update(number: 1, text: "Activity was delivered as intended using the associated materials and activities")
q1.answers.find_or_create_by(text: "delivery-modified").update(number: 2, text: "Activity was presented but delivery was modified")
q1.answers.find_or_create_by(text: "content-modified").update(number: 3, text: "Activity was delivered but content was modified")
q1.answers.find_or_create_by(text: "not-delivered").update(number: 4, text: "Activity was not presented")
q2 = fidelity.questions.find_or_create_by(identifier: "engagement")
q2.update(number: 2, question_type: :single_choice, required: true, text: "How much participant engagement occurred during this session?")
q2.answers.find_or_create_by(text: "low").update(number: 1, text: "Low engagement: 10–30% of participants")
q2.answers.find_or_create_by(text: "moderate").update(number: 2, text: "Moderate engagement: 40–70% of participants")
q2.answers.find_or_create_by(text: "high").update(number: 3, text: "High engagement: 80–100% of participants")
q3 = fidelity.questions.find_or_create_by(identifier: "delivery-modified-follow-up")
q3.update(number: 3, question_type: :long_answer, required: false, text: "Provide a brief explanation describing why the delivery was changed and areas for improvement.")
q4 = fidelity.questions.find_or_create_by(identifier: "content-modified-follow-up")
q4.update(number: 4, question_type: :long_answer, required: false, text: "Provide a brief explanation describing why the activity was changed and areas for improvement.")
q5 = fidelity.questions.find_or_create_by(identifier: "not-delivered-follow-up")
q5.update(number: 5, question_type: :long_answer, required: false, text: "Provide a brief explanation describing why the activity was not presented and areas for improvement.")
q6 = fidelity.questions.find_or_create_by(identifier: "additional-comments")
q6.update(number: 6, question_type: :long_answer, required: false, text: "If there were any additional implementation challenges, provide a brief explanation below. If there were no challenges or all challenges were documented above, write N/A.")

# Find/Create program observation form
observation = Questionnaire.find_by(title: "program observation")
observation ||= Questionnaire.create!(title: "program observation")
q1 = observation.questions.find_or_create_by(identifier: "introduction")
q1.update(number: 1, question_type: :text, required: false, text: "<p>The purpose of the observation form is to measure the fidelity and quality of
implementation of the program delivery. The person who completes this form (i.e., the observer) should
be someone who attends program sessions and is neither a facilitator nor a participant. Please use the
guidelines below when completing the observation form and do not change the scoring provided; for
example, do not select multiple answers or score a 1.5 rather than a 1 or a 2.</p> <p><b>You should complete the observation form <i>after viewing the entire session,</i> but you should read
through the questions prior to the observation.</b> It is also helpful to take notes during your viewing;
for example, for Question 1, each time a facilitator gives an explanation, place a checkmark next
to the appropriate rating.</p>")
q2 = observation.questions.find_or_create_by(identifier: "instructions")
q2.update(number: 2, question_type: :text, required: false, text: "The following questions assess the overall quality of the program session and delivery
of the information. Use your best judgment and do not select more than one response.")
q3 = observation.questions.find_or_create_by(identifier: "clarity")
q3.update(number: 3, question_type: :single_choice, required: true, text: "<b>In general, how clear were the program facilitator’s explanations of activities?</b>")
q3.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Not clear")
q3.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q3.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Moderately clear")
q3.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q3.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Very clear")
q3.update(answer_instructions: "1 - Most participants do not understand instructions and cannot proceed; many questions asked.<br>
3 - About half of the group understands, while the other half ask questions for clarification.<br>
5 - 90-100% of the participants begin and complete the activity/discussion with no hesitation and no questions.")
q4 = observation.questions.find_or_create_by(identifier: "time-management")
q4.update(number: 4, question_type: :single_choice, required: true, text: "<b>To what extent did the facilitator keep track of time during the session and activities?</b>")
q4.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Not at all")
q4.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q4.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Somewhat")
q4.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q4.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "A lot")
q4.update(answer_instructions: "1 - Facilitator does not have time to complete the material (particularly at the end of the session); regularly allows discussions to drag on (e.g., participants seem bored or begin discussing non-related issues in small groups).<br>3 - Misses a few points; sometimes allows discussions to drag on.<br>5 - Completes all content of the session; completes activities and discussions in a timely manner (using the suggested time limitations in the program manual, if available).")
q5 = observation.questions.find_or_create_by(identifier: "speed")
q5.update(number: 5, question_type: :single_choice, required: true, text: "<b>To what extent did the presentation of materials seem rushed or hurried?</b>")
q5.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Very rushed")
q5.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q5.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Somewhat rushed")
q5.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q5.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Not at all rushed")
q5.update(answer_instructions: "1 - Facilitator doesn’t allow time for discussion; doesn’t have time for examples;
tells participants they are in a hurry; body language suggests stress or hurry.<br>3 - Some deletion of discussion/activities; sometimes states but does not explain material.<br>5 - Does not rush participants or speech but still completes all the materials; appears relaxed.")
q6 = observation.questions.find_or_create_by(identifier: "comrehension")
q6.update(number: 6, question_type: :single_choice, required: true, text: "<b>To what extent did the participants appear to understand the material?</b>")
q6.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Little understanding")
q6.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q6.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Some understanding")
q6.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q6.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Good understanding")
q6.update(answer_instructions: "Use your best judgment based on participant conversations and feedback.<br>
Roughly: 1 - Less than 25% seem to understand; 3 - About half; 5 - 75-100% understand.")
q7 = observation.questions.find_or_create_by(identifier: "participation")
q7.update(number: 7, question_type: :single_choice, required: true, text: "<b>How actively did the group members participate in discussions and activities?</b>")
q7.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Little participation")
q7.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q7.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Some participation")
q7.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q7.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Active participation")
q7.update(answer_instructions: "Use your best judgment based on participant discussions and feedback.<br>
Roughly, 1 - Less than 25% participate; 3 - About half participate. 5 - 75-100% participate.")
q8 = observation.questions.find_or_create_by(identifier: "rating")
q8.update(number: 8, question_type: :text, required: true, text: "<b>On the following scale, rate the facilitator on the following qualities:</b>")
q9 = observation.questions.find_or_create_by(identifier: "knowledge")
q9.update(number: 9, question_type: :single_choice, required: true, text: "<b>Knowledge of the program</b>")
q9.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
q9.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q9.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
q9.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q9.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
q9.update(answer_instructions: "1 - Cannot answer questions, mispronounces names; reads from the manual.<br>
5 - Provides information above and beyond what’s in the manual; seems very familiar with the concepts and answers questions with ease.")
q10 = observation.questions.find_or_create_by(identifier: "enthusiasm")
q10.update(number: 10, question_type: :single_choice, required: true, text: "<b>Level of enthusiasm</b>")
q10.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
q10.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q10.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
q10.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q10.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
q10.update(answer_instructions: "1 - Presents information in a dry and boring way; lacks personal connection to material;
appears “burned out.”<br>5 - Makes clear that the program is a great opportunity; gets participants talking and
excited; outgoing.")
q11 = observation.questions.find_or_create_by(identifier: "confidence")
q11.update(number: 11, question_type: :single_choice, required: true, text: "<b>Poise and confidence</b>")
q11.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
q11.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q11.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
q11.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q11.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
q11.update(answer_instructions: "1 - Appears nervous or hurried; does not have good eye contact.<br>5 - Does not hesitate in addressing concerns. Well organized, not nervous.")
q12 = observation.questions.find_or_create_by(identifier: "communication")
q12.update(number: 12, question_type: :single_choice, required: true, text: "<b>Rapport and communication with participants</b>")
q12.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
q12.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q12.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
q12.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q12.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
q12.update(answer_instructions: "1 – Doesn’t remember names; does not 'connect' with participants; acts distant or unfriendly.<br>5 - Gets participants talking and excited; very friendly; uses people’s names when appropriate;
seems to understand the community and its needs.")
q13 = observation.questions.find_or_create_by(identifier: "concerns")
q13.update(number: 13, question_type: :single_choice, required: true, text: "<b>Ability to address questions/concerns</b>")
q13.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
q13.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q13.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
q13.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q13.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
q13.update(answer_instructions: "1 - Engages in 'power struggles'; responds negatively to comments; gives inaccurate
information; doesn’t direct participants elsewhere for further info.<br>5 - Answers questions of fact with information, questions of value with validation; if doesn’t
know the answer, is honest about it and directs them elsewhere.")
q14 = observation.questions.find_or_create_by(identifier: "quality")
q14.update(number: 14, question_type: :single_choice, required: true, text: "<b>Rate the overall quality of the program session.</b>")
q14.answers.find_or_create_by(text: "1").update(number: 1, text: "1", label: "Poor")
q14.answers.find_or_create_by(text: "2").update(number: 2, text: "2")
q14.answers.find_or_create_by(text: "3").update(number: 3, text: "3", label: "Average")
q14.answers.find_or_create_by(text: "4").update(number: 4, text: "4")
q14.answers.find_or_create_by(text: "5").update(number: 5, text: "5", label: "Excellent")
q14.update(answer_instructions: "Summary measure of all the preceding questions. Assesses both the extent of material covered
and the performance of the facilitator.<br>
Excellent sessions look like:<br><ul><li>Participants are doing rather than talking about activities</li><li>Non-judgmental responses to questions</li><li>Answering questions of fact with information, questions of value with validation</li><li>Good time management and well organized</li><li>Adequate pacing—not too fast and did not drag</li><li>Using effective checks for understanding</li></ul>
Poor sessions look like:<ul><li>Lecture-style of presenting the content</li><li>Reading the content from the notebook</li><li>Stumbling along with the content and failing to make connections to what
has been discussed previously or what participants are contributing</li><li>Uninvolved participants</li><li>Getting into power struggles with participants about the content</li><li>Judgmental responses</li><li>Flat affect and boring style</li><li>Unorganized and random</li><li>Loses track of time</li></ul>")
q15 = observation.questions.find_or_create_by(identifier: "activities-planned")
q15.update(number: 15, question_type: :number_answer, required: true, text: "<b>Number of activities planned for this session (as indicated in the lesson plans):</b>")
q16 = observation.questions.find_or_create_by(identifier: "activities-completed")
q16.update(number: 16, question_type: :number_answer, required: true, text: "<b>Number of activities completed during this session:</b>")
q17 = observation.questions.find_or_create_by(identifier: "optional-questions")
q17.update(number: 17, question_type: :text, required: false, text: "<b>Note:</b> The following questions (18, 19, and 20) are for grantee’s internal use only for program improvement
purposes. These questions are optional and will not be reported to the Office of Population Affairs (OPA)
for performance measurement purposes.")
q18 = observation.questions.find_or_create_by(identifier: "implementation-problems")
q18.update(number: 18, question_type: :long_answer, required: false, text: "<b>Briefly describe any implementation problems you noticed, including any major changes to the
content or delivery of the material; time wasted in getting the session started or finished, etc:</b>")
q19 = observation.questions.find_or_create_by(identifier: "major-strengths")
q19.update(number: 19, question_type: :long_answer, required: false, text: "<b>Please note at least one major strength of the session and/or facilitator’s delivery of the material:</b>")
q20 = observation.questions.find_or_create_by(identifier: "other-comments")
q20.update(number: 20, question_type: :long_answer, required: false, text: "<b>Other Comments: Use the space below for additional comments regarding strengths or
weaknesses of the session, particularly if there is anything that affected your ratings above.</b>")
