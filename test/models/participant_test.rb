# == Schema Information
#
# Table name: participants
#
#  id         :bigint           not null, primary key
#  category   :string           default("Youth")
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  study_id   :string
#
# Indexes
#
#  index_participants_on_study_id  (study_id) UNIQUE
#
require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
