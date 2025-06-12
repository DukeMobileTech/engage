# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  answers          :json
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  participant_id   :integer
#  questionnaire_id :integer          not null
#  sitting_id       :integer
#  user_id          :integer
#
# Indexes
#
#  index_responses_on_discarded_at      (discarded_at)
#  index_responses_on_participant_id    (participant_id)
#  index_responses_on_questionnaire_id  (questionnaire_id)
#  index_responses_on_sitting_id        (sitting_id)
#  index_responses_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (participant_id => participants.id)
#  fk_rails_...  (questionnaire_id => questionnaires.id)
#  fk_rails_...  (sitting_id => sittings.id)
#
require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
