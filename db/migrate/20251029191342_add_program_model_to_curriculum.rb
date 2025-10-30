class AddProgramModelToCurriculum < ActiveRecord::Migration[8.0]
  def change
    add_column :curriculums, :program_model, :string
  end
end
