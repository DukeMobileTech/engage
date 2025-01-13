class AddInstructionsToQuestion < ActiveRecord::Migration[8.0]
  def change
    add_column :answers, :label, :string
    add_column :questions, :answer_instructions, :text
  end
end
