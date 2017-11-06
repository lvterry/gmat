class RenameColumnInExamTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :exams, :type, :exam_type
  end
end
