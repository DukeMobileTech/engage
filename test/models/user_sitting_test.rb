# == Schema Information
#
# Table name: user_sittings
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sitting_id :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_sittings_on_sitting_id  (sitting_id)
#  index_user_sittings_on_user_id     (user_id)
#
# Foreign Keys
#
#  sitting_id  (sitting_id => sittings.id)
#  user_id     (user_id => users.id)
#
require "test_helper"

class UserSittingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
