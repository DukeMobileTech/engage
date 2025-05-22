# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  label       :string
#  number      :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class Answer < ApplicationRecord
  default_scope { order(:number) }
  belongs_to :question

  validates :text, presence: true
end
