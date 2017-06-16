class AddMathGuideToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :math_guide, :text
  end
end
