class AddLabelsToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :difficulty, :text, array: true, default: []
    add_column :exercises, :book, :text, array: true, default: []
    add_column :exercises, :subject, :text, array: true, default: []
  end
end
