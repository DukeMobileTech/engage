# == Schema Information
#
# Table name: section_data_uploads
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  data_upload_id :integer          not null
#  section_id     :integer          not null
#
# Indexes
#
#  index_section_data_uploads_on_data_upload_id  (data_upload_id)
#  index_section_data_uploads_on_section_id      (section_id)
#
# Foreign Keys
#
#  data_upload_id  (data_upload_id => data_uploads.id)
#  section_id      (section_id => sections.id)
#
class SectionDataUpload < ApplicationRecord
  belongs_to :section
  belongs_to :data_upload
end
