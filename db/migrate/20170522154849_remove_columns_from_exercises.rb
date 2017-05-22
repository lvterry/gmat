class RemoveColumnsFromExercises < ActiveRecord::Migration[5.0]
  def change
    remove_column :exercises, :subject
    remove_column :exercises, :book
    remove_column :exercises, :difficulty
  end
end
