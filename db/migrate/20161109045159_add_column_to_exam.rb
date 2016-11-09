class AddColumnToExam < ActiveRecord::Migration[5.0]
  def change
    add_column :exams, :done_question, :integer
  end
end
