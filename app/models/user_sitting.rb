# == Schema Information
#
# Table name: user_sittings
#
#  id         :bigint           not null, primary key
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
#  fk_rails_...  (sitting_id => sittings.id)
#  fk_rails_...  (user_id => users.id)
#
class UserSitting < ApplicationRecord
  belongs_to :user
  belongs_to :sitting
end
