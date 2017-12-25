class ChangeExamExercisesColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :exams, :exercises, :verbal_exercises
    add_column :exams, :quant_exercises, :string
  end
end
