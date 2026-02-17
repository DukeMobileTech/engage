class CreateCascadeLessonAttendancesTrigger < ActiveRecord::Migration[8.0]
  def up
    # Create the trigger function that cascades deletion of lesson_attendances
    # when a section_participant is deleted
    execute <<-SQL
      CREATE OR REPLACE FUNCTION cascade_section_participant_deletion()
      RETURNS TRIGGER AS $$
      BEGIN
        DELETE FROM lesson_attendances
        WHERE participant_id = OLD.participant_id
        AND sitting_lesson_id IN (
          SELECT sl.id FROM sitting_lessons sl
          INNER JOIN sittings s ON sl.sitting_id = s.id
          WHERE s.section_id = OLD.section_id
        );
        RETURN OLD;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # Create the trigger on section_participants table
    execute <<-SQL
      DROP TRIGGER IF EXISTS cascade_section_participant_deletion_trigger
      ON section_participants;

      CREATE TRIGGER cascade_section_participant_deletion_trigger
      BEFORE DELETE ON section_participants
      FOR EACH ROW
      EXECUTE FUNCTION cascade_section_participant_deletion();
    SQL
  end

  def down
    # Clean up the trigger and function
    execute "DROP TRIGGER IF EXISTS cascade_section_participant_deletion_trigger ON section_participants;"
    execute "DROP FUNCTION IF EXISTS cascade_section_participant_deletion();"
  end
end
