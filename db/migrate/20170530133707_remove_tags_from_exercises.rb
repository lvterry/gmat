class RemoveTagsFromExercises < ActiveRecord::Migration[5.0]
  def change
    remove_column :exercises, :exercise_tags
  end
end
