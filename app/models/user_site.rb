# == Schema Information
#
# Table name: user_sites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_sites_on_site_id  (site_id)
#  index_user_sites_on_user_id  (user_id)
#
# Foreign Keys
#
#  site_id  (site_id => sites.id)
#  user_id  (user_id => users.id)
#
class UserSite < ApplicationRecord
  belongs_to :user
  belongs_to :site
end
