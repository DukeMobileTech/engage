class AddCascadeToSectionParticipantResponse < ActiveRecord::Migration[8.0]
  def change
    # remove existing FK if present
    if foreign_key_exists?(:section_participant_responses, :section_participants)
      remove_foreign_key :section_participant_responses, :section_participants
    end

    # add FK with ON DELETE CASCADE
    add_foreign_key :section_participant_responses, :section_participants, on_delete: :cascade
  end
end
