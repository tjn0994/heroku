class AddColumnStatusToExam < ActiveRecord::Migration[5.0]
  def change
    add_column :exams, :status,:integer, default: 0
  end
end
